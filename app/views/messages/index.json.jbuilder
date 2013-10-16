json.array!(@messages) do |message|
  json.extract! message, :content, :sent_at, :is_read
  json.url message_url(message, format: :json)
end
