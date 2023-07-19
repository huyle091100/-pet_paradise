class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  enum status: [:active, :inactive]
end
