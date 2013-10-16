json.array!(@temp_analisies) do |temp_analisy|
  json.extract! temp_analisy, :lowest_rate, :medium_rate, :highest_rate, :algoritms_rate, :period, :date
  json.url temp_analisy_url(temp_analisy, format: :json)
end
