class NotificationsMailer < ActionMailer::Base

  default :to => "mitchnick@gmail.com"
  default :from => "info@futurenicks.com"

  def contact_us(message)
    @message = message
    mail( :subject => "New Message received from #{message.name}",
          :from => message.email)
  end

end