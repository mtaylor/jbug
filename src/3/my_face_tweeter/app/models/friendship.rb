class Friendship < ActiveRecord::Base
  after_initialize :do_something
#  before_validation :do_something
  attr_accessible :friend_id, :user_id

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def do_something
    puts "This happened before the validation"
  end
end
