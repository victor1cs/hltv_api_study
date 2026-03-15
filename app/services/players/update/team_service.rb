class Players::Update::TeamService
  def self.call(player, team_name)
    return remove_team(player) if team_name.blank?

    update_team(player, team_name)
  end

  private

  def self.remove_team(player)
    return error("Player already has no team") if player.team.nil?

    player.update(team: nil)
    success("Player updated to no team")
  end

  def self.update_team(player, team_name)
    team = ::Teams::FindService.call(team_name)
    return error("Team not found") unless team
    return error("Player already belongs to team #{team.name}") if player.team_id == team.id
    return error("Team is full") if team.players.count == 5

    player.update(team: team)
    success("Player updated to team #{team.name}")
  end

  def self.success(message)
    { success: true, message: message }
  end

  def self.error(message)
    { success: false, message: message }
  end
end
