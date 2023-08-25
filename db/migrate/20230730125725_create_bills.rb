class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.string :order_id
      t.decimal :amount
      t.integer :status
      t.string :order_info
      t.string :message
      t.string :result_code
      t.string :trans_id
      t.string :pay_type
      t.bigint :response_time

      t.timestamps
    end
  end
end
