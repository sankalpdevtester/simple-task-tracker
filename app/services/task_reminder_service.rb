class TaskReminderService
  def initialize(task)
    @task = task
  end

  def send_reminder
    TaskNotificationService.new(@task).send_reminder
  end

  def self.run_daily
    TaskNotificationService.send_daily_reminders
  end
end
