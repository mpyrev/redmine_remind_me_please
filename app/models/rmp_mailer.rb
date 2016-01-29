class RmpMailer < Mailer
  include Redmine::I18n

  def self.deliver_notification(reminder)
    reminder.get_recipients.each do |u|
      notification(reminder, u).deliver
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