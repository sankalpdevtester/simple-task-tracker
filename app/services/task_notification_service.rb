class TaskNotificationService
  def initialize(task)
    @task = task
  end

  def send_reminder
    return unless @task.due_date && @task.user
    return unless (Date.current..(Date.current + 1.day)).cover?(@task.due_date)

    TaskMailer.reminder(@task).deliver_later
  end

  def self.send_daily_reminders
    Task.includes(:user).where(due_date: Date.current..(Date.current + 1.day)).find_each do |task|
      new(task).send_reminder
    end
  end
end
