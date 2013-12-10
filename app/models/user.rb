class User < ActiveRecord::Base
  has_many :sent_messages, :class_name => "Message", :foreign_key => "sender_id"
  has_many :recivers, :through => :sent_messages, :source => :reciver do 
    def for_message(message_id)
      where(id: message_id)
    end
  end
  has_many :user_analyses
  has_many :analisies, :through => :user_analyses
  
  has_attached_file :avatar,  :default_url => "/assets/default.jpg"
  
  before_save :prepare_to_save
  
  validates :first_name, :presence =>true
  validates :last_name, :presence =>true
  validates :email, :presence =>true, :uniqueness=>true
  validates :password, :confirmation =>true, :presence =>true, :length => { :minimum => 5, :maximum => 40 }
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
  
  def full_name
    self.first_name + " " +self.last_name
  end
  
  def prepare_to_save
    if self.new_record?
      crypted_password = Digest::MD5.hexdigest(self.password)
      self.password = crypted_password
      self.registration_hash = Digest::MD5.hexdigest((0...8).map { (65 + rand(26)).chr }.join)
      self.status = 0;
    end
  end
  
  def get_analysies_history(page=1, filters=[])
    items_amount = 3.0
    start_with = (page-1)*items_amount
    
    base_query = self.analisies.joins(:company).select(:company_id, 'companies.name').distinct
    if filters != nil
      if filters[0] == 'company'
        base_query = self.analisies.where(:company_id => filters[1]).joins(:company).select(:company_id, 'companies.name').distinct
      else
        if filters[0] == 'index'
          base_query = self.analisies.joins(:company).joins('INNER JOIN cindices ON cindices.company_id = companies.id').where('cindices.index_id' => filters[1]).select('companies.id as company_id', 'companies.name').distinct
        end
      end
    end
    analysis_companies = base_query.order('companies.name ASC').limit(items_amount).offset(start_with)
    analysis_companies_ids = analysis_companies.map{|elem| elem.company_id }

    analysis_dates = self.analisies.joins(:company).where(:company_id => analysis_companies_ids).select([:company_id, :date, 'companies.name', 'companies.full_id']).distinct.order('companies.name ASC, date DESC')
    
    count_query = self.analisies.select(:company_id).distinct.count
    if filters != nil
      if filters[0] == 'company'
        count_query = self.analisies.where(:company_id => filters[1]).select(:company_id).distinct.count
      else
        if filters[0] == 'index'
         count_query = self.analisies.joins(:company).joins('INNER JOIN cindices ON cindices.company_id = companies.id').where('cindices.index_id' => filters[1]).select(:company_id).distinct.count
        end
      end
    end
    
    response = {}
    response[:total_pages] = (count_query / items_amount).ceil
    response[:analysis] = {}.tap do |result|
      analysis_dates.each do |elem|
        if result[elem['company_id']] == nil
          elem = elem.attributes
          elem['periods'] = self.analisies.where(:company_id => elem['company_id'], :date => elem['date']).order(date: :desc, period: :asc)
          elem['dates'] = [elem['date']]
          result[elem['company_id']] = elem
        end
        result[elem['company_id']]['dates'].push(elem['date']).uniq!
      end
    end
    response
  end
  
  def get_user_company_analysis_for_day(company_id, date)
    {}.tap do |result|
      result['periods'] = self.analisies.where(:company_id => company_id, :date => date).order(date: :desc, period: :asc)
    end
  end
  
  def has_analysis?
    self.analisies.count > 0
  end
end