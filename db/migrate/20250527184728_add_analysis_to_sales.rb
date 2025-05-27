class AddAnalysisToSales < ActiveRecord::Migration[7.2]
  def change
    add_column :sales, :analysis, :json
    add_column :sales, :analyzed_at, :datetime
  end
end
