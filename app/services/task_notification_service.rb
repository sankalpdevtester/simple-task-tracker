# app/services/task_notification_service.rb

class TaskNotificationService
  def initialize(task)
    @task = task
  end

  def send_reminder
    return unless @task.due_date && @task.user

    TaskMailer.with(task: @task).reminder_email.deliver_later
  end

  def self.send_daily_reminders
    Task.where("due_date <= ?", Date.today).each do |task|
      new(task).send_reminder
    end
  end
end

# Usage in tasks_controller.rb
class TasksController < ApplicationController
  def create
    # ...
    TaskNotificationService.new(@task).send_reminder
    # ...
  end
end

# Usage in task_mailer.rb
class TaskMailer < ApplicationMailer
  def reminder_email
    @task = params[:task]
    mail to: @task.user.email, subject: "Task Reminder: #{@task.title}"
  end
end

# Usage in task_reminder_service.rb
class TaskReminderService
  def self.send_reminders
    TaskNotificationService.send_daily_reminders
  end
end

# Add a cron job to run daily reminders
# config/schedule.rb
every 1.day, at: '8:00 am' do
  runner "TaskNotificationService.send_daily_reminders"
end