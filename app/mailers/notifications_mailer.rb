class NotificationsMailer < ActionMailer::Base

  default :to => ["mitchnick@gmail.com", "emily.budde@gmail.com"]
  default :from => "info@futurenicks.com"

  def contact_us(message)
    @message = message
    mail( :subject => "New Message received from #{message.name}",
          :from => message.email)
  end

  def rsvp_created(rsvp_id)
    @rsvp = Rsvp.find(rsvp_id)
    mail( :subject => "Futurenicks: New RSVP Submitted")
  end

  def rsvp_updated(rsvp_id)
    @rsvp = Rsvp.find(rsvp_id)
    mail( :subject => "Futurenicks: RSVP Updated")
  end

  def guest_confirmation(rsvp_id)
    @rsvp = Rsvp.find(rsvp_id)
    mail( subject: "WOOO HOOO!", to: @rsvp.email )
  end

end