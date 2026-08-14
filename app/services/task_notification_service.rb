# app/services/task_notification_service.rb

class TaskNotificationService
  def initialize(task)
    @task = task
  end

  def send_reminder
    return unless @task.due_date && @task.user

    # Calculate the time until the task is due
    time_until_due = (@task.due_date - Time.current)

    # Check if the task is due soon (less than 1 day)
    if time_until_due < 1.day
      # Send a reminder email to the user
      TaskMailer.with(task: @task, user: @task.user).reminder_email.deliver_later
    end
  end

  def self.send_daily_reminders
    # Get all tasks that are due today or tomorrow
    tasks = Task.where("due_date >= ? AND due_date <= ?", Date.current, Date.current + 1.day)

    # Send reminders for each task
    tasks.each do |task|
      TaskNotificationService.new(task).send_reminder
    end
  end
end
```

```ruby
# app/mailers/task_mailer.rb (updated)
class TaskMailer < ApplicationMailer
  def reminder_email
    @task = params[:task]
    @user = params[:user]

    mail to: @user.email, subject: "Task Reminder: #{@task.name}"
  end
end
```

```ruby
# config/environments.rb (updated)
Rails.application.configure do
  # ...

  # Send daily reminders at 8am
  TaskNotificationService.send_daily_reminders
end
```

```ruby
# app/controllers/tasks_controller.rb (updated)
class TasksController < ApplicationController
  # ...

  def create
    @task = Task.new(task_params)

    if @task.save
      # Send a reminder for the new task
      TaskNotificationService.new(@task).send_reminder

      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # ...
end