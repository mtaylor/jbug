class TweetProcessor < TorqueBox::Messaging::MessageProcessor
  include TorqueBox::Injectors

  def on_message(body)
    # Find the sender
    #puts ENV['RACK_ENV']
    ::MyFaceTweeter::Application::User.first

    # puts "Found User"
    # # Add a new message to each friends messages
    # ([user] + user.friends).each do |friend|
      # friend.messages << Message.new(:sender_id => user.id,
                                     # :body => body[:body])
      # friend.save
    # end
  end

  def on_error(exception)
    raise exception
  end
end