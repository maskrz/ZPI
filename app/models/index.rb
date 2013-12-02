class Index < ActiveRecord::Base
  has_many :cindices
  has_many :companies, :through => :cindices
  
end
