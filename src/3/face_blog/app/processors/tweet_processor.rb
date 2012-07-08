class TweetProcessor < TorqueBox::Messaging::MessageProcessor
  include TorqueBox::Injectors

  def on_message(body)
    puts body.inspect
  end

  def on_error(exception)
    raise exception
  end
end
