class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.references :guest, null: false
      t.integer :confirmed_number
      t.text :message
      t.string :email
      t.timestamps
    end
  end
end
