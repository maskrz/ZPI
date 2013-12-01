class Message < ActiveRecord::Base
  has_one :sender, :class_name => "User", :foreign_key => "sender_id"
  has_one :reciver, :class_name => "User", :foreign_key => "reciver_id"
  
  def sender
    User.where(:id => self.sender_id)
  end
  def reciver
    User.where(:id => self.reciver_id)
  end
  
  def is_sender?(id)
    id == self.sender_id
  end
end
