# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
match 'issues/:issue_id/reminders/new', :to => 'rmp_reminders#new', :as => :new_rmp_reminder, :via => 'get'
match 'issues/:issue_id/reminders/create', :to => 'rmp_reminders#create', :via => 'post'
