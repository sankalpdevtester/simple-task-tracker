class TaskSchedulingService
  def initialize(task)
    @task = task
  end

  def schedule
    return unless @task.due_date

    reminder_time = @task.due_date.in_time_zone.beginning_of_day - 1.day
    job = TaskReminderJob
    reminder_time > Time.current ? job.set(wait_until: reminder_time).perform_later(@task.id) : job.perform_later(@task.id)
  end

  def self.send_reminders
    TaskNotificationService.send_daily_reminders
  end
end
