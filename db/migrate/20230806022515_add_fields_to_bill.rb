class AddFieldsToBill < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :first_name, :string
    add_column :bills, :last_name, :string
    add_column :bills, :address, :string
    add_column :bills, :phone_number, :string
  end
end
