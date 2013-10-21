class Company < ActiveRecord::Base
  attr_accessible :companies_indices_id, :index_id
  has_many :analisies
  has_many :temp_analisies
  has_many :companies_indices
  has_many :indices, :through => :companies_indices
end
