class User < ActiveRecord::Base
  has_many :sent_messages, :class_name => "Message", :foreign_key => "sender_id"
    has_many :recivers, :through => :sent_messages, :source => :reciver do 
        def for_message(message_id)
            where("messages.id = ?", message_id)
        end
    end
  has_many :user_analyses
  has_many :analisies, :through => :user_analyses
  
  def authenticate (pass)
    self.password == pass
  end
  
  def display_name
    self.first_name + " " +self.last_name + "  "+ self.email
  end
  
end