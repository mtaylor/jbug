class MessagesController < ApplicationController
  def create
    @message = Message.new(params[:message])

    # Send Message Here

    redirect_to :back
  end
end