class AddColumnStatusToSales < ActiveRecord::Migration[7.2]
  def change
    add_column :sales, :status, :string
    add_index :sales, :status
  end
end
