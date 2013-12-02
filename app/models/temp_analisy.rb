class TempAnalisy < ActiveRecord::Base
  belongs_to :company
  
  def display_name
    self.period.to_s + " "+self.date.to_s+" "+self.company.shortcut.to_s + " " +self.medium_rate.to_s
  end
  
end
