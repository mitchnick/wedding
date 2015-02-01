class Rsvp < ActiveRecord::Base
  belongs_to :guest

  validates_presence_of :guest_id, :confirmed_number, :email

  delegate :invited_count, :full_name, :display_name, to: :guest

  def show_custom_message
    if message.present?
      message
    else
      "none"
    end
  end

  def self.total_confirmed_count
    all.map(&:confirmed_number).reduce(:+)
  end

  def self.total_possible_count
    all.map(&:invited_count).reduce(:+)
  end

  def self.percent_responded
    get_percentage(count.to_f / Guest.count)
  end

  def self.attendance_percent
    get_percentage(Rsvp.total_confirmed_count.to_f / Rsvp.total_possible_count)
  end

  def self.get_percentage(number)
    (number * 100).round(1).to_s + "%"
  end

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
