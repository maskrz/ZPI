class TempAnalisy < ActiveRecord::Base
  belongs_to :company
  
  def display_name
    self.first_name + " " +self.last_name + "  "+ self.email
  end
  
end
