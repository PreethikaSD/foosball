json.extract! game, :id, :score, :round_no, :match_id, :team_id, :player_id, :created_at, :updated_at
json.url game_url(game, format: :json)
