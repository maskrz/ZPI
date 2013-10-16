json.array!(@indices) do |index|
  json.extract! index, :name
  json.url index_url(index, format: :json)
end
