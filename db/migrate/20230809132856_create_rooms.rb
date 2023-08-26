class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :r_type
      t.decimal :price
      t.integer :weight
      t.integer :quantity

      t.timestamps
    end
  end
end
