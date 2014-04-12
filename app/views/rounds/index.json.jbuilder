json.array!(@rounds) do |round|
  json.extract! round, :id, :movie, :score, :game_id
  json.url round_url(round, format: :json)
end
