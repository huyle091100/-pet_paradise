class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
