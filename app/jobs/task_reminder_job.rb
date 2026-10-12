class TaskReminderJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.includes(:user).find_by(id: task_id)
    return unless task&.user && task.due_date
    return unless (Date.current..(Date.current + 1.day)).cover?(task.due_date)

    TaskMailer.reminder(task).deliver_now
  end
end
