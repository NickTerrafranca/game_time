read_team_data = [
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]

leader_board = {
  "Patriots"=>{:wins=>3, :losses=>0},
  "Broncos"=>{:wins=>1, :losses=>1},
  "Colts"=>{:wins=>0, :losses=>2},
  "Steelers"=>{:wins=>0, :losses=>1}
}


# def display_team(csv)
#   leaderboard = aggregate_leaderboard(TEAM_DATA_FILE)
#   team_list = []
#   leaderboard.each do |key, value|
#     # unless team_list.include?(key)
#       team_list << key
#     # end
#   end
#   team_list
#   binding.pry
# end
# display_team(TEAM_DATA_FILE)
