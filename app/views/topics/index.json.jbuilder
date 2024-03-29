json.array!(@topics) do |topic|
  json.extract! topic, :id, :title, :description, :forum_id, :user_id
  json.url topic_url(topic, format: :json)
end
