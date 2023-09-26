class AddQuantityToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :quantity, :integer, default: 0
  end
end
