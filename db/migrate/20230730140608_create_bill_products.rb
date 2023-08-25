class CreateBillProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :bill_products do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.integer :quantity
      t.decimal :total_amount

      t.timestamps
    end
  end
end
