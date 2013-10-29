class Analisy < ActiveRecord::Base
  belongs_to :company
  has_many :user_analyses
  has_many :users, :through => :user_analyses
end
