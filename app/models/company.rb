class Company < ActiveRecord::Base
  has_many :analisies
  has_many :temp_analisies
  has_many :cindices
  has_many :indices, :through => :cindices
end
