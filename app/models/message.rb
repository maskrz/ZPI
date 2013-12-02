class Message < ActiveRecord::Base
  has_one :sender, :class_name => "User", :foreign_key => "sender_id"
  has_one :reciver, :class_name => "User", :foreign_key => "reciver_id"
  
  validates_presence_of :content
  
  def is_sender?(id)
    id == self.sender_id
  end
end
