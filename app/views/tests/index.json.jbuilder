json.array!(@tests) do |test|
  json.extract! test, :id, :slug, :title, :description, :user_id
  json.url test_url(test, format: :json)
end
