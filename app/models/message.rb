class Message < ActiveRecord::Base
  has_one :sender, :class_name => "User", :foreign_key => "sender_id"
  has_one :reciver, :class_name => "User", :foreign_key => "reciver_id"
  
  validates :content, :presence =>true
  validates :reciver_id, :presence =>true
  
  def is_sender?(id)
    id == self.sender_id
  end
end
