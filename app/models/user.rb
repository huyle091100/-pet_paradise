class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :confirmable, :validatable
  has_many :carts, dependent: :destroy
  has_many :bills, dependent: :destroy
  after_create_commit do
    create_chat
  end

  after_destroy do
    Chat.find_by(sender_id: self.id).destroy
  end
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def create_chat
    Chat.create sender_id: self.id, receiver_id: User.with_role(:admin).first.id, status: :read
  end
end
