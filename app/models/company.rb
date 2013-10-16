class Company < ActiveRecord::Base
  has_many :analisies, :temp_analisies, :companys_indices
  has_many :indices, :through => :companys_indices
end
