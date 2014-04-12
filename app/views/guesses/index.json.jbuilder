json.array!(@guesses) do |guess|
  json.extract! guess, :id, :round_id, :attempt, :player_id
  json.url guess_url(guess, format: :json)
end
