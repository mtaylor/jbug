class MessagesController < ApplicationController
  include TorqueBox::Injectors

  def create
    message = Message.new(params[:message])

    # Lookup the queue
    queue = inject "/queues/tweet"

    # Publish message
    queue.publish(:body => message.body, :sender_id => current_user.id)

    redirect_to :back
  end
end
