json.extract! video, :id, :title, :description, :duration, :price, :approved, :clip_data, :balance, :views, :user_id, :created_at, :updated_at
json.url video_url(video, format: :json)
