class CreateCindices < ActiveRecord::Migration
  def change
    drop_table :companies_indices  if self.table_exists?("companies_indices")
    create_table :cindices do |t|
      t.references :company
      t.references :index
    end
  end
end
