class CreateCompanysIndices < ActiveRecord::Migration
  def change
    create_table :companys_indices do |t|
      t.references :company
      t.references :index
    end
  end
end
