# app/services/task_notification_service.rb

class TaskNotificationService
  def initialize(task)
    @task = task
  end

  def send_reminder
    # Send reminder email to user
    TaskMailer.reminder(@task).deliver_now
  end

  def send_update
    # Send update email to user
    TaskMailer.update(@task).deliver_now
  end

  def send_notification
    # Send notification to user based on task status
    case @task.status
    when 'pending'
      send_reminder
    when 'completed'
      send_update
    end
  end

  def self.send_daily_reminders
    # Send daily reminders for pending tasks
    Task.where(status: 'pending').each do |task|
      TaskNotificationService.new(task).send_reminder
    end
  end

  def self.send_daily_updates
    # Send daily updates for completed tasks
    Task.where(status: 'completed').each do |task|
      TaskNotificationService.new(task).send_update
    end
  end
end
```

```ruby
# app/mailers/task_mailer.rb (updated)
class TaskMailer < ApplicationMailer
  def reminder(task)
    @task = task
    mail to: task.user.email, subject: 'Task Reminder'
  end

  def update(task)
    @task = task
    mail to: task.user.email, subject: 'Task Update'
  end
end
```

```ruby
# app/controllers/tasks_controller.rb (updated)
class TasksController < ApplicationController
  def create
    # ...
    TaskNotificationService.new(@task).send_notification
    # ...
  end

  def update
    # ...
    TaskNotificationService.new(@task).send_notification
    # ...
  end
end
```

```ruby
# config/environments.rb (updated)
Rails.application.configure do
  # ...
  config.after_initialize do
    TaskNotificationService.send_daily_reminders
    TaskNotificationService.send_daily_updates
  end
end