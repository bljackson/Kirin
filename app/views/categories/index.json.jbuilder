json.array!(@categories) do |category|
  json.extract! category, :id, :name, :description, :position
  json.url category_url(category, format: :json)
end
