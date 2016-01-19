desc <<-END_DESC
Send notifications

Example:
  rake redmine:remind_me_please:remind RAILS_ENV="production"
END_DESC
# require File.expand_path(File.dirname(__FILE__) + '/../../../../config/environment')

namespace :redmine do
  namespace :remind_me_please do
    task :remind => :environment do
      puts 'Checking for reminders to work with'
      RmpReminder.remind!
    end
  end
end
