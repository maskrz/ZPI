class User < ActiveRecord::Base
  has_many :messages
  has_many :user_analyses
  has_many :analisies, :through => :user_analyses
  
  def authenticate (pass)
    self.password == pass
  end
  
  def display_name
    self.first_name + " " +self.last_name + "  "+ self.email
  end
  
end