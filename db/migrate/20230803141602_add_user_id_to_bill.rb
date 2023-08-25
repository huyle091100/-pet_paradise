class AddUserIdToBill < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :user_id, :integer
  end
end
