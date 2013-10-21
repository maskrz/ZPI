json.array!(@cindices) do |cindex|
  json.extract! cindex, 
  json.url cindex_url(cindex, format: :json)
end
