class OpenPlusOneToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :open_plus_one, :string
  end
end
