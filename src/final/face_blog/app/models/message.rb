class Message < ActiveRecord::Base
  belongs_to :message
  attr_accessible :body, :sender_id, :user_id
end
