json.array!(@forums) do |forum|
  json.extract! forum, :id, :name, :description, :position
  json.url forum_url(forum, format: :json)
end
