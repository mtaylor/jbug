class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:id])

    current_user.friends << friend

    # The current user shall subscribe to this friends posts
    topic = TorqueBox::Messaging::Topic.new "/topics/#{friend.id}", :client_id => "client_{current_user.id}"
    topic.receive(:durable => true, :subscriber_name => "subscriber_#{current_user.id}", :timeout => 100)

    redirect_to root_path
  end

  def destroy
    current_user.friends.delete(current_user.friends.find(params[:id]))
    redirect_to root_path
  end

end
