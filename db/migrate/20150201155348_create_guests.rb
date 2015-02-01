class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :display_name
      t.integer :invited_count
      t.string :custom_message
      t.timestamps
    end
  end
end
