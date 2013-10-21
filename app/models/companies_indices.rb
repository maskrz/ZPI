class CompanysIndices < ActiveRecord::Base
  belongs_to :company
  belongs_to :index
end
