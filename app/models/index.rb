class Index < ActiveRecord::Base
  has_many :cindices
  has_many :companies, :through => :cindices
  
  def get_companies(index_id)
    Companies.where("index_id = ?", index_id);
  end
end
