class Index < ActiveRecord::Base
  has_many :companys_indices
  has_many :companies, :through => :companys_indices
end
