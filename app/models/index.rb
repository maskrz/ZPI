class Index < ActiveRecord::Base
  attr_accessible :companies_indices_id, :company_id
  has_many :companies_indices
  has_many :companies, :through => :companies_indices
end
