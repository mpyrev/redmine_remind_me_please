require 'redmine'
require 'issue_patch'

Redmine::Plugin.register :redmine_remind_me_please do
  name 'Remind Me Please'
  author 'Mikhail Pyrev'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'https://github.com/mpyrev'
  require_dependency 'rmp_hook_listener'

  project_module :issue_tracking do
    permission :view_issue_reminders, {:rmp_reminders => [:index, :show]}, :read => true
    permission :add_issue_reminder, {:rmp_reminders => [:new, :create]}
    permission :edit_issue_reminder, {:rmp_reminders => [:edit, :update]}
    permission :delete_issue_reminder, {:rmp_reminders => [:destroy]}, :require => :member
  end

  # Send patches to models and controllers
  Rails.configuration.to_prepare do
    Issue.send(:include, IssuePatch)
  end
end
