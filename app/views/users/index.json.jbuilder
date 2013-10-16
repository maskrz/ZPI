json.array!(@users) do |user|
  json.extract! user, :first_name, :last_name, :email, :password, :password_hash, :registration_hash, :last_logged_at, :status
  json.url user_url(user, format: :json)
end
