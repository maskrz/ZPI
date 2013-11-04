class CreateCompanies < ActiveRecord::Migration
  def change
    drop_table :companies if self.table_exists?("companies")
    create_table :companies do |t|
      t.string :shortcut
      t.string :name
      t.string :full_id

      t.timestamps
    end
  end
end
