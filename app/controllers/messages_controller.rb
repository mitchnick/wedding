class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.contact_us(@message).deliver
      redirect_to root_url, notice: "Message sent! Thank you for contacting us."
    else
      redirect_to root_url, notice: "There was an issue with your form below."
    end
  end
end