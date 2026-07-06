# app/services/task_scheduling_service.rb

class TaskSchedulingService
  def initialize(task)
    @task = task
  end

  def schedule
    # Check if the task has a due date
    return unless @task.due_date.present?

    # Calculate the due date in seconds
    due_date_in_seconds = @task.due_date.to_time.to_i

    # Schedule a reminder 1 day before the due date
    reminder_time = due_date_in_seconds - 1.day.to_i

    # Create a new scheduled task
    ScheduledTask.create(
      task_id: @task.id,
      reminder_time: reminder_time,
      due_date: due_date_in_seconds
    )
  end

  def self.send_reminders
    # Get all scheduled tasks that are due for a reminder
    scheduled_tasks = ScheduledTask.where("reminder_time <= ?", Time.current.to_i)

    # Send reminders for each task
    scheduled_tasks.each do |scheduled_task|
      task = Task.find(scheduled_task.task_id)
      user = task.user

      # Send a notification to the user
      NotificationService.send_notification(
        user,
        "Reminder: #{task.name} is due on #{task.due_date}"
      )

      # Delete the scheduled task
      scheduled_task.destroy
    end
  end
end

class ScheduledTask < ApplicationRecord
  belongs_to :task
end

class NotificationService
  def self.send_notification(user, message)
    # Send a notification to the user (e.g. via email or in-app notification)
    # For this example, we'll just log the message
    Rails.logger.info("Sending notification to #{user.email}: #{message}")
  end
end
```

```ruby
# db/migrate/20230220144510_create_scheduled_tasks.rb
class CreateScheduledTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :scheduled_tasks do |t|
      t.references :task, null: false, foreign_key: true
      t.integer :reminder_time, null: false
      t.integer :due_date, null: false

      t.timestamps
    end
  end
end
```

```ruby
# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  # ...

  def create
    @task = Task.new(task_params)
    if @task.save
      TaskSchedulingService.new(@task).schedule
      # ...
    end
  end

  # ...
end
```

```ruby
# config/scheduler.rb
Rails.application.configure do
  config.after_initialize do
    TaskSchedulingService.send_reminders
  end
end