require 'json'

file = Rails.root.join('db/data/teams.json')
teams_data = JSON.parse(File.read(file))

teams_data.each do |team_data|
  team = Team.find_or_create_by(name: team_data["name"]) do |t|
    t.ranking = team_data["ranking"]
    t.logo = team_data["logo"]
  end

  team_data["players"].each do |player_data|
    country_data = player_data["country"]

    country = Country.find_or_create_by(name: country_data["name"]) do |c|
      c.flag = country_data["flag"]
    end

    player = Player.find_or_initialize_by(nickname: player_data["nickname"])

    player.name = player_data["fullname"]
    player.image = player_data["image"]
    player.team = team
    player.country = country

    player.save!
  end
end

puts "Seed completed!"
