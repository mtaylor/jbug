class User < ActiveRecord::Base

  after_create :create_topic

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :messages

  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :dob, :presence => true
  validate :must_be_an_adult

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :dob
  # attr_accessible :title, :body

  def must_be_an_adult
    if (Time.now - 18.years) < dob
      errors.add(:age, "Must be over 18")
    end
  end

  def create_topic
    Thread.new do
      # Create a new topic, this users messages will be sent here:
      TorqueBox::Messaging::Topic.start "/topics/#{id}"
      puts topic
  
      # Setup a duable subscription to this topic
      topic = TorqueBox::Messaging::Topic.new "/topics/#{id}", :client_id => "client_#{id}"
      topic.receive(:durable => true, :subscriber_name => "subscriber_#{id}", :timeout => 0)
      topic.destroy
    end
  end

  # Creates a new message for each message our friend has sent.
  #
  # Torquebox does not yet support listeners for dynamically created topics.  So
  # we'll need to iterate through each topic, creating a message for each on the list
  def read_topics
    ([self] + friends).each do |friend|
      puts "reading topic for: #{friend.name}"
      # Lookup the topic
      topic = TorqueBox::Messaging::Topic.new "/topics/#{friend.id}"#, :client_id => "client_#{id}"
# 
      # # Read message and create new object representing the message
      while m = topic.receive(:timeout => 100)
        puts "found message"
        messages << Message.new(:body => m, :sender => friend)
      end
      # topic = nil
    end
    save
  end

  def send_message(body)
    topic = TorqueBox::Messaging::Topic.new "/topics/#{id}"
    topic.publish body
  end
end
