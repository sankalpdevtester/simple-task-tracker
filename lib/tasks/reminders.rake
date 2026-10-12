namespace :tasks do
  desc 'Queue reminders for tasks due today or tomorrow'
  task send_reminders: :environment do
    TaskNotificationService.send_daily_reminders
  end
end
