json.array!(@user_analyses) do |user_analysis|
  json.extract! user_analysis, :rate
  json.url user_analysis_url(user_analysis, format: :json)
end
