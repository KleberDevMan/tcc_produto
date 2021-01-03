json.extract! profile, :id, :name, :description, :active, :permissions, :namespace, :created_at, :updated_at
json.url profile_url(profile, format: :json)
