class CreateRmpReminders < ActiveRecord::Migration
  def change
    create_table :rmp_reminders do |t|
      t.boolean :periodic
      t.date :base_date # When first notification comes in. Needed for monthly repeats.
      t.date :notification_date # Changes after every notification
      t.integer :interval_value
      t.string :interval_type
      t.integer :issue_id
    end
  end
end
