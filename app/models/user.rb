class User < ActiveRecord::Base
  has_many :user_analyses, :messages
  
  def authenticate (pass)
    self.password == pass
  end
  
end
