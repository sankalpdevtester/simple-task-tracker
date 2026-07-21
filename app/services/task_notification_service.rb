# app/services/task_notification_service.rb

class TaskNotificationService
  def initialize(task)
    @task = task
  end

  def send_reminder
    return unless @task.due_date && @task.user

    # Calculate the time until the task is due
    time_until_due = (@task.due_date - Time.current)

    # Send a reminder if the task is due within the next 24 hours
    if time_until_due <= 24.hours
      TaskMailer.reminder(@task).deliver_now
    end
  end

  def self.send_daily_reminders
    Task.where("due_date <= ?", Time.current + 1.day).each do |task|
      TaskNotificationService.new(task).send_reminder
    end
  end
end
```

```ruby
# app/mailers/task_mailer.rb (updated)
class TaskMailer < ApplicationMailer
  def reminder(task)
    @task = task
    mail to: task.user.email, subject: "Task Reminder: #{@task.title}"
  end
end
```

```ruby
# config/environments.rb (updated)
Rails.application.configure do
  # ...
  config.after_initialize do
    TaskNotificationService.send_daily_reminders
  end
end
```

```ruby
# app/controllers/tasks_controller.rb (updated)
class TasksController < ApplicationController
  # ...
  def create
    # ...
    TaskNotificationService.new(@task).send_reminder
    # ...
  end

  def update
    # ...
    TaskNotificationService.new(@task).send_reminder
    # ...
  end
end