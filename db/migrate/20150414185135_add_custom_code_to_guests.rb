class AddCustomCodeToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :custom_rsvp_code, :string
  end
end
