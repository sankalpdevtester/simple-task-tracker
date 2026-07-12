# app/services/task_notification_service.rb

class TaskNotificationService
  def initialize(task)
    @task = task
  end

  def send_reminder
    # Check if the task has a reminder set
    return unless @task.reminder_at

    # Calculate the time until the reminder
    time_until_reminder = (@task.reminder_at - Time.current).to_i

    # Send a reminder email if the time until the reminder is less than 1 day
    if time_until_reminder < 1.day
      TaskMailer.reminder(@task).deliver_now
    end
  end

  def send_update_notification
    # Send a notification email to the task owner when the task is updated
    TaskMailer.update_notification(@task).deliver_now
  end

  def send_completion_notification
    # Send a notification email to the task owner when the task is completed
    TaskMailer.completion_notification(@task).deliver_now
  end
end

# Usage example:
# task = Task.find(1)
# TaskNotificationService.new(task).send_reminder
# TaskNotificationService.new(task).send_update_notification
# TaskNotificationService.new(task).send_completion_notification
```

```ruby
# app/mailers/task_mailer.rb (updated)
class TaskMailer < ApplicationMailer
  def reminder(task)
    @task = task
    mail to: @task.user.email, subject: "Reminder: #{@task.title}"
  end

  def update_notification(task)
    @task = task
    mail to: @task.user.email, subject: "Task updated: #{@task.title}"
  end

  def completion_notification(task)
    @task = task
    mail to: @task.user.email, subject: "Task completed: #{@task.title}"
  end
end
```

```ruby
# app/controllers/tasks_controller.rb (updated)
class TasksController < ApplicationController
  # ...

  def update
    # ...
    TaskNotificationService.new(@task).send_update_notification
    # ...
  end

  def complete
    # ...
    TaskNotificationService.new(@task).send_completion_notification
    # ...
  end
end