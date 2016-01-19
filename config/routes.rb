# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
match 'issues/:issue_id/reminders/new', :to => 'rmp_reminders#new', :as => :new_rmp_reminder, :via => 'get'
match 'issues/:issue_id/reminders/create', :to => 'rmp_reminders#create', :via => 'post'
match 'reminders/:id/edit', :to => 'rmp_reminders#edit', :as => :edit_rmp_reminder, :via => 'get'
match 'reminders/:id/update', :to => 'rmp_reminders#update', :via => [:put, :patch]
match 'reminders/:id', :to => 'rmp_reminders#destroy', :as => :destroy_rmp_reminder, :via => [:delete]
