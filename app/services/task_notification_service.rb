# app/services/task_notification_service.rb

class TaskNotificationService
  def initialize(task)
    @task = task
  end

  def send_reminder
    # Check if task has a due date and is not completed
    return unless @task.due_date && !@task.completed

    # Calculate time until due date
    time_until_due = (@task.due_date - Time.current).to_i

    # Send reminder if due date is within 24 hours
    if time_until_due <= 24.hours
      TaskMailer.reminder(@task).deliver_now
    end
  end

  def send_update_notification(user)
    # Send notification to user when task is updated
    TaskMailer.update_notification(@task, user).deliver_now
  end

  def send_completion_notification(user)
    # Send notification to user when task is completed
    TaskMailer.completion_notification(@task, user).deliver_now
  end
end

# Usage example in tasks_controller.rb
class TasksController < ApplicationController
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      TaskNotificationService.new(@task).send_update_notification(current_user)
      render json: @task
    else
      render json: @task.errors
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.update(completed: true)
    TaskNotificationService.new(@task).send_completion_notification(current_user)
    render json: @task
  end
end

# Usage example in task_reminder_service.rb
class TaskReminderService
  def send_reminders
    Task.all.each do |task|
      TaskNotificationService.new(task).send_reminder
    end
  end
end