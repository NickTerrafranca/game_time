require 'sinatra'
require 'csv'
require 'pry'
TEAM_DATA_FILE = 'team_data.csv'

def read_team(csv)
  team_data = []
  CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
    team_data << row.to_hash
  end
  team_data
end

def aggregate_leaderboard(csv)
  game_data = read_team(TEAM_DATA_FILE)
  leaderboard = {}
  game_data.each do |game|
    home_team = game[:home_team]
    away_team = game[:away_team]
    home_score = game[:home_score].to_i
    away_score = game[:away_score].to_i

    unless leaderboard.key?(home_team)
      leaderboard[home_team] = { wins: 0, losses: 0 }
    end

    unless leaderboard.key?(away_team)
      leaderboard[away_team] = { wins: 0, losses: 0 }
    end

    if home_score > away_score
      leaderboard[home_team][:wins] += 1
      leaderboard[away_team][:losses] += 1
    else
      leaderboard[home_team][:losses] += 1
      leaderboard[away_team][:wins] += 1
    end
  end
  leaderboard
end

get('/') do
  @game_data = read_team(TEAM_DATA_FILE)
  erb :index
end

get('/:leaderboard') do
  @leaderboard = aggregate_leaderboard(TEAM_DATA_FILE)
  erb :leaderboard
end


