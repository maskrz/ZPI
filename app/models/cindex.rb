class Cindex < ActiveRecord::Base
  attr_accessible :company_id, :index_id
  belongs_to :company
  belongs_to :index
end
