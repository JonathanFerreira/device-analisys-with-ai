class CreateSales < ActiveRecord::Migration[7.2]
  def change
    create_table :sales do |t|
      t.string :title

      t.timestamps
    end
  end
end
