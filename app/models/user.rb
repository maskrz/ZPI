class User < ActiveRecord::Base
  has_many :sent_messages, :class_name => "Message", :foreign_key => "sender_id"
  has_many :recivers, :through => :sent_messages, :source => :reciver do 
    def for_message(message_id)
      where(id: message_id)
    end
  end
  has_many :user_analyses
  has_many :analisies, :through => :user_analyses
  
  before_save :prepare_to_save
  
  validates :first_name, :presence =>true
  validates :last_name, :presence =>true
  validates :email, :presence =>true,
                    :uniqueness=>true
  validates :password, :presence =>true,
                    :length => { :minimum => 5, :maximum => 40 },
                    :confirmation =>true
  validates_confirmation_of :password
  validates_acceptance_of :accept_statuate
  
  def authenticate (pass)
    self.password == pass
  end
  
  def display_name
    self.first_name + " " +self.last_name + "  "+ self.email
  end
  
  def prepare_to_save
    if self.new_record?
      crypted_password = Digest::MD5.hexdigest(self.password)
      self.password = crypted_password
      self.registration_hash = Digest::MD5.hexdigest(self.first_name+  self.password + self.last_name)
      self.status = 0;
    end
  end
  
end