json.extract! user, :id, :full_name, :phone_number, :created_at, :updated_at
json.url user_url(user, format: :json)
