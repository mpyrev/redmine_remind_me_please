class RmpMailer < ActionMailer::Base
  include Redmine::I18n

  def self.default_url_options
    { :host => Setting.host_name, :protocol => Setting.protocol }
  end

  def self.deliver_notification(reminder)
    reminder.get_recipients.each do |u|
      m = notification(reminder, u)
      puts m.body
      m.deliver
    end
  end

  def notification(reminder, user)
    set_language_if_valid user.language
    @issue = reminder.issue
    @reminder = reminder
    mail :to => user.mail,
         :subject => "[#{@issue.project.name} - #{@issue.tracker.name} ##{@issue.id}][Reminder] #{@issue.subject}",
         :template_path => 'rmp_mailer',
         :template_name => 'notification'
  end
end