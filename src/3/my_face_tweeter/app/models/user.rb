class User < ActiveRecord::Base

  include TorqueBox::Injectors

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

  def send_message(message)
    queue = inject "/queues/tweet"
    queue.publish(:body => message, :sender_id => id)
  end
end
