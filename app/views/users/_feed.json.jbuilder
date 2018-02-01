json.extract! user, :id, :profile_image, :created_at, :updated_at
json.url feed_url(user, format: :json)
