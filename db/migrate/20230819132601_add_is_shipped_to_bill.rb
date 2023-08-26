class AddIsShippedToBill < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :is_shipped, :boolean, default: false
  end
end
