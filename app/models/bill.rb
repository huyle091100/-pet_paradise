class Bill < ApplicationRecord
  has_many :bill_products
  enum status: [:unpaid, :paid]
end
