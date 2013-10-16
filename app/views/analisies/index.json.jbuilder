json.array!(@analisies) do |analisy|
  json.extract! analisy, :lowest_rate, :medium_rate, :highest_rate, :algoritms_rate, :period, :date
  json.url analisy_url(analisy, format: :json)
end
