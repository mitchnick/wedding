require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
