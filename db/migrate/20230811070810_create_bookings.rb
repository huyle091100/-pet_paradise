class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :room_id
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :user_id

      t.timestamps
    end
  end
end
