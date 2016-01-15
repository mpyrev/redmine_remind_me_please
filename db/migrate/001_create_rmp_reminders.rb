class CreateRmpReminders < ActiveRecord::Migration
  def change
    create_table :rmp_reminders do |t|
      t.boolean :periodic
      t.date :start_date
      t.integer :interval_value
      t.string :interval_type
      t.integer :issue_id
    end
  end
end
