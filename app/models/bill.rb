class Bill < ApplicationRecord
  has_many :bill_products, dependent: :destroy
  belongs_to :user
  enum status: [:unpaid, :paid]
end
