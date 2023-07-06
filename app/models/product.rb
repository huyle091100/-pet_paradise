class Product < ApplicationRecord
  has_one_attached :image

  def image_url
    if self.image.attachment
      self.image.attachment.url
    end
  end
end
