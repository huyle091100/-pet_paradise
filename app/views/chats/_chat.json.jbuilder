json.extract! chat, :id, :sender_id, :receiver_id, :status, :created_at, :updated_at
json.url chat_url(chat, format: :json)
