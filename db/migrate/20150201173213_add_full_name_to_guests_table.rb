class AddFullNameToGuestsTable < ActiveRecord::Migration
  def change
    add_column :guests, :full_name, :string
  end
end
