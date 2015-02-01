class Guest < ActiveRecord::Base
  has_one :rsvp

  validates_presence_of :display_name, :invited_count, :full_name

  def open_plus_one?
    open_plus_one == "yes"
  end
end

# == Schema Information
#
# Table name: guests
#
#  id             :integer          not null, primary key
#  display_name   :string(255)
#  invited_count  :integer
#  custom_message :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  full_name      :string(255)
#  open_plus_one  :string(255)
#
