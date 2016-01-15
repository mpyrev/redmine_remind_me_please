class RemindMePleaseHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, :partial => 'remind_me_please/show_reminders'
end
