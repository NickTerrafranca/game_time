require 'sinatra'
require 'csv'
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
  leaderboard.sort_by do |key, value|
    value[:losses]
  end
end

def game_opponent_data(input, csv)
  team_data = read_team(TEAM_DATA_FILE)
  user_input = input
  game_array = []
  team_data.each do |game|
    if game.has_value?(user_input)
      game_array << game
    end
  end
  game_array
end

def total_wins_losses(input, csv)
  user_selection = input
  team_data = aggregate_leaderboard(TEAM_DATA_FILE)
  selection = []
  team_data.each do |team, standing|
    if user_selection == team
      selection << standing
    end
  end
  selection
end

get('/') do
  @game_data = aggregate_leaderboard(TEAM_DATA_FILE)
  erb :index
end

get('/teams/:team_details') do
  @team_name = params[:team_details]
  @game_opponents = game_opponent_data(@team_name, TEAM_DATA_FILE)
  @team_totals = total_wins_losses(@team_name, TEAM_DATA_FILE)
  erb :team_details
end

get('/leaderboard') do
  @leaderboard = aggregate_leaderboard(TEAM_DATA_FILE)
  erb :leaderboard
end
