class Bill < ApplicationRecord
  has_many :bill_products
  belongs_to :user
  enum status: [:unpaid, :paid]
end
