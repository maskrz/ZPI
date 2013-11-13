class CreateUserAnalyses < ActiveRecord::Migration
  def change
    drop_table :user_analyses if self.table_exists?("user_analyses")
    create_table :user_analyses do |t|
      t.float :rate
      t.references :user
      t.references :analisy
      t.timestamps
    end
  end
end
