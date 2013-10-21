class Index < ActiveRecord::Base
  attr_accessible :cindices_id, :company_id
  has_many :cindices
  has_many :companies, :through => :cindices
  
  def getCompanies(index_id)
    Companies.where("index_id = ?", index_id)
  end
end
