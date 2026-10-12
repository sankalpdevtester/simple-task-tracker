class TaskMailer < ApplicationMailer
  def reminder(task)
    @task = task
    mail(to: task.user.email, subject: "Task reminder: #{task.title}") do |format|
      format.text do
        render plain: "Your task #{task.title.inspect} is due on #{task.due_date}.\n\n#{task.description}"
      end
    end
  end
end
