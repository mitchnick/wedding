class Guest < ActiveRecord::Base
  before_save :lowercase_custom_rsvp_code

  has_one :rsvp

  validates_presence_of :display_name, :invited_count, :full_name, :custom_rsvp_code
  validates_uniqueness_of :custom_rsvp_code

  def open_plus_one?
    open_plus_one == "yes"
  end

  private

  def lowercase_custom_rsvp_code
    self.custom_rsvp_code.downcase!
  end
end

# == Schema Information
#
# Table name: guests
#
#  id               :integer          not null, primary key
#  display_name     :string(255)
#  invited_count    :integer
#  custom_message   :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  full_name        :string(255)
#  open_plus_one    :string(255)
#  custom_rsvp_code :string(255)
#
