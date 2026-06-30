# app/services/task_reminder_service.rb

class TaskReminderService
  def initialize(task)
    @task = task
  end

  def send_reminder
    return unless @task.due_date && @task.due_date < Time.current + 1.day

    UserMailer.with(task: @task).task_reminder.deliver_later
  end

  def self.run_daily
    Task.where("due_date <= ?", Time.current + 1.day).each do |task|
      new(task).send_reminder
    end
  end
end
```

```ruby
# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def task_reminder
    @task = params[:task]
    mail to: @task.user.email, subject: "Task Reminder: #{@task.title}"
  end
end
```

```ruby
# config/environments.rb
Rails.application.configure do
  # ...
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
end
```

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  # ...
  before_action :run_daily_reminders

  private

  def run_daily_reminders
    TaskReminderService.run_daily
  end
end
```

```ruby
# db/migrate/20230220144510_add_due_date_to_tasks.rb
class AddDueDateToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :due_date, :datetime
  end
end
```

```ruby
# app/models/task.rb
class Task < ApplicationRecord
  belongs_to :user

  validates :title, :due_date, presence: true
end
```

```ruby
# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  # ...
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :due_date)
  end
end