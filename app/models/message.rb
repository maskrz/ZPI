class Message < ActiveRecord::Base
  has_one :sender, :class_name => "User", :foreign_key => "sender_id"
  has_one :reciver, :class_name => "User", :foreign_key => "reciver_id"
end
