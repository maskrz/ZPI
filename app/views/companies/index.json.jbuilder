json.array!(@companies) do |company|
  json.extract! company, :shortcut, :name, :description
  json.url company_url(company, format: :json)
end
