require 'test_helper'

class RsvpTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: rsvps
#
#  id               :integer          not null, primary key
#  guest_id         :integer          not null
#  confirmed_number :integer
#  message          :text
#  email            :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
