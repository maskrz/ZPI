class User < ActiveRecord::Base
  has_many :sent_messages, :class_name => "Message", :foreign_key => "sender_id"
  has_many :recivers, :through => :sent_messages, :source => :reciver do 
    def for_message(message_id)
      where(id: message_id)
    end
  end
  has_many :user_analyses
  has_many :analisies, :through => :user_analyses
  has_attached_file :avatar
  
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
    self.password == Digest::MD5.hexdigest(pass)
  end
  
  def is_active?
    self.status != 0
  end
  
  def display_name
    self.first_name + " " +self.last_name + " "+ self.email
  end
  
  def prepare_to_save
    if self.new_record?
      crypted_password = Digest::MD5.hexdigest(self.password)
      self.password = crypted_password
      self.registration_hash = Digest::MD5.hexdigest((0...8).map { (65 + rand(26)).chr }.join)
      self.status = 0;
    end
  end
  
  def get_analysies_history(page=1, filter_indices=[], filter_companies=[])
    items_amount = 3
    start_with = (page-1)*items_amount
    where = {}
    where.index_id = filter_indices if filter_indices.length != 0
    
    analysis_companies = self.analisies.joins(:company).select(:company_id, 'companies.name').distinct.order('companies.name ASC').limit(items_amount).offset(start_with)
    analysis_companies_ids = analysis_companies.map{|elem| elem.company_id } # .where(where)

    if filter_companies.blank?
      companies_ids = analysis_companies_ids
    else
      companies_ids = analysis_companies_ids & filter_companies
    end
    analysis_dates = self.analisies.joins(:company).where(:company_id => companies_ids).select([:company_id, :date, 'companies.name', 'companies.full_id']).distinct.order('companies.name ASC')
    
    analysis_dates.map do |elem|
      elem = elem.attributes
      puts elem.inspect
      elem['periods'] = self.analisies.where(:company_id => elem['company_id'], :date => elem['date'])
      elem
    end
  end
end