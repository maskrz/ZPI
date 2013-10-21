class Message < ActiveRecord::Base
  attr_accessible :sender_id, :reciver_id
  has_one :sender, :class_name => "User", :foreign_key => "sender_id"
  has_one :reciver, :class_name => "User", :foreign_key => "reciver_id"
end
