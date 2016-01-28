class AddRecipients < ActiveRecord::Migration
  def up
    change_table :rmp_reminders do |t|
      t.integer :recipient_type, :default => 0, :null => false
      t.integer :owner_id, :default => 1, :null => false
    end

    create_table :rmp_reminders_users, :id => false do |t|
      t.references :rmp_reminder, :null => false
      t.references :user, :null => false
    end

    add_index :rmp_reminders_users, [:rmp_reminder_id, :user_id], :unique => true
  end

  def down
    remove_column :rmp_reminders, :recipient_type
    remove_column :rmp_reminders, :owner_id
    drop_table :rmp_reminders_users
  end
end
