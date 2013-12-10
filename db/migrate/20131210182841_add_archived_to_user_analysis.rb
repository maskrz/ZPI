class AddArchivedToUserAnalysis < ActiveRecord::Migration
  def change
    add_column :user_analyses, :archived, :boolean, :default => false
  end
end
