class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy
  enum r_type: [:apartment, :vip, :penthouse]
  enum weight: [:less_than_5, :five_to_ten, :ten_to_fifteen, :fifteen_to_twenty, :greater_than_20]
end
