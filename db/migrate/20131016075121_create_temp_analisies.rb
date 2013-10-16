class CreateTempAnalisies < ActiveRecord::Migration
  def change
    create_table :temp_analisies do |t|
      t.float :lowest_rate
      t.float :medium_rate
      t.float :highest_rate
      t.string :algoritms_rate
      t.integer :period
      t.date :date
      
      t.references :company

      t.timestamps
    end
  end
end
