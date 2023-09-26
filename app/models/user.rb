class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :validatable
  has_many :carts, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :phone_number, format: {with: /\A\d{10,12}\z/, message: "Please enter a valid phone number", allow_blank: true}

  after_destroy do
    Chat.find_by(sender_id: self.id).destroy
  end
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # def create_chat
  #   return if self.has_role?(:admin) || self.has_role?(:staff)
  #   Chat.create sender_id: self.id, status: :read
  # end
end
