class Company < ActiveRecord::Base
  has_many :analisies
  has_many :temp_analisies
  has_many :companys_indices
  has_many :indices, :through => :companys_indices
end
