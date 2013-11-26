class ChangeAnalysisTabels < ActiveRecord::Migration
  def change
    rename_column :analisies, :lowest_rate, :current_rate
    rename_column :analisies, :highest_rate, :percentage_rate
    rename_column :temp_analisies, :lowest_rate, :current_rate
    rename_column :temp_analisies, :highest_rate, :percentage_rate
  end
end