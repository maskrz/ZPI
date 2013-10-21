class Analisy < ActiveRecord::Base
  attr_accessible :company_id
  belongs_to :company
  has_many :user_analyses
  has_many :users, :through => :user_analyses
end
