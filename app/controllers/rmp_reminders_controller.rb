class RmpRemindersController < ApplicationController
  unloadable

  before_filter :set_interval_types

  def new
    @reminder = RmpReminder.new
    @reminder.issue = Issue.find(params[:issue_id])
  end

  def create
    @reminder = RmpReminder.new(params[:rmp_reminder])
    @reminder.issue = Issue.find(params[:issue_id])
    if @reminder.save
      flash[:notice] = l(:reminder_created)
      redirect_to :controller => :issues, :action => :show, :id => @reminder.issue.id
    else
      render :new
    end
  end

private
  # def set_recurrable_issues
  #   if @project
  #     @recurrable_issues = @project.issues
  #   else
  #     @recurrable_issues = Issue.all
  #   end
  # end
  #
  # def find_recurring_task
  #   begin
  #     @recurring_task = RecurringTask.find(params[:id])
  #   rescue ActiveRecord::RecordNotFound
  #     show_error "#{l(:error_recurring_task_not_found)} #{params[:id]}"
  #   end
  # end

  def set_interval_types
    @interval_types = RmpReminder::INTERVAL_TYPES_LOCALIZED.collect{|k,v| [v, k]}
  end
end

