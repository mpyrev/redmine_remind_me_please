class RmpRemindersController < ApplicationController
  unloadable

  before_filter :set_interval_types
  before_filter :find_reminder, :except => [:new, :create]
  before_filter :find_issue
  before_filter :find_project, :authorize

  def new
    @reminder = RmpReminder.new
    @reminder.issue = @issue
  end

  def create
    @reminder = RmpReminder.new(params[:rmp_reminder])
    @reminder.issue = @issue
    @reminder.notification_date = @reminder.base_date
    if @reminder.save
      flash[:notice] = l(:reminder_created)
      redirect_to :controller => :issues, :action => :show, :id => @reminder.issue.id
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @reminder.update_attributes(params[:rmp_reminder])
      @reminder.notification_date = @reminder.base_date
      @reminder.save!
      flash[:notice] = l(:reminder_saved)
      redirect_to :controller => :issues, :action => :show, :id => @reminder.issue.id
    else
      render :edit
    end
  end

  def destroy
    if @reminder.destroy
      flash[:notice] = l(:reminder_removed)
      redirect_to :back
    else
      flash[:notice] = l(:error_reminder_could_not_remove)
      render :back
    end
  end

private
  def find_reminder
    begin
      @reminder = RmpReminder.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      show_error "#{l(:error_reminder_not_found)} #{params[:id]}"
    end
  end

  def find_issue
    if defined?(@reminder)
      # Updating methods
      @issue = @reminder.issue
    else
      # Creation methods
      @issue = Issue.find(params[:issue_id])
    end
  end

  def set_interval_types
    @interval_types = RmpReminder::INTERVAL_TYPES_LOCALIZED.collect{|k,v| [v, k]}
  end

  def find_project
    @project = @issue.project
  end
end
