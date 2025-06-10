class CreateSaleCycles < ActiveRecord::Migration[7.2]
  def change
    create_table :sale_cycles do |t|
      t.references :sale, null: false, foreign_key: true
      t.string :imei, index: true
      t.string :step, index: true
      t.string :kind, index: true

      t.timestamps
    end
  end
end
