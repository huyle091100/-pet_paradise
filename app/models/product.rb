class Product < ApplicationRecord
  has_one_attached :image
  has_many :carts
  enum :category, [:dog, :cat, :bird, :small_animal, :fish]

  def image_url
    if self.image.attachment
      self.image.attachment.url
    end
  end
end
