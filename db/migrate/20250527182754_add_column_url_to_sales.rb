class AddColumnUrlToSales < ActiveRecord::Migration[7.2]
  def change
    add_column :sales, :url, :string
  end
end
