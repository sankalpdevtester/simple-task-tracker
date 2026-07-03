class TaskMailer < ApplicationMailer
  def reminder(task)
    @task = task
    mail to: task.user.email, subject: 'Task Reminder: ' + task.title
  end
end