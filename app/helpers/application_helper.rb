module ApplicationHelper

  def bootstrap_class_for flash_type
    case flash_type.to_sym
      when :success
        "alert-success"
      when :error, :danger
        "alert-danger"
      when :alert
        "alert-warning"
      when :notice, :info
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def top_button_class
    "btn btn-default"
  end

  def form_class_width
    "col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3"
  end

  def display_field(name, value)
    value = "-" if value.nil? || value == ""
    content_tag(:dl, class: "dl-horizontal") do
      name[0] = name[0].capitalize
      content_tag(:dt, name) +
      content_tag(:dd, value.to_s.html_safe)
    end
  end

  def display_calculation(name, value)
    content_tag(:p) do
      content_tag(:span, name, class: "bold") +
      " - " + value.to_s
    end
  end

  def display_possible_guests(guest)
    guests_count = []
    for i in 0..guest.invited_count
      guests_count << [text_for_guests(i, guest), i]
    end
    guests_count.reverse
  end

  def text_for_guests(current_count, guest)
    if guest.open_plus_one?
      if current_count > 2
        current_count.to_s + " - I'm coming with guests"
      elsif current_count == 2
        "2 - I'm coming and bringing a plus one"
      elsif current_count == 1
        "1 - I'll be attending without a plus one"
      else # current_count == 0
        "0 - Sorry, I won't be able to make it, but will celebrate from afar"
      end
    else
      if current_count == guest.invited_count
        current_count.to_s + " - We're all able to make it!"
      elsif current_count != 0
        "#{current_count}"
      else
        "0 - We'll be celebrating from afar"
      end
    end
  end

  def custom_message_for(guest)
    if guest.custom_message.present?
      guest.custom_message
    else
      "Thank you for submitting an RSVP for our wedding on July 25."
    end
  end

end
