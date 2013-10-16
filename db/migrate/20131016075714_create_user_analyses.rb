class CreateUserAnalyses < ActiveRecord::Migration
  def change
    create_table :user_analyses do |t|
      t.float :rate
      t.references :user
      t.references :analisies
      
      t.timestamps
    end
  end
end
