class MessagesController < ApplicationController

  def create
    @message = Message.new(params[:message])

    current_user.send_message @message.body
    redirect_to :back
  end

end
