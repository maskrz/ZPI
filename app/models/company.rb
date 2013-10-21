class Company < ActiveRecord::Base
  attr_accessible :cindex_id, :index_id
  has_many :analisies
  has_many :temp_analisies
  has_many :cindices
  has_many :indices, :through => :cindices
end
