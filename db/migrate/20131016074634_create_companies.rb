class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :shortcut
      t.string :name
      t.string :full_id

      t.timestamps
    end
  end
end
