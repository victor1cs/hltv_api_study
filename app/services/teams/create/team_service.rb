module Teams
  module Create
    class TeamService
      def self.call(name, players_params)
        validate_players_count(players_params)

        ActiveRecord::Base.transaction do
          team = create_team(name)
          create_players(team, players_params)

          success(team)
        end
      rescue ActiveRecord::RecordInvalid => e
        handle_error(e)
      end

      private

      def self.validate_players_count(players_params)
        return if players_params&.size == 5

        raise ArgumentError, "Team must have exactly 5 players"
      end

      def self.create_team(name)
        Team.create!(name: name)
      end

      def self.create_players(team, players_params)
        players_params.each do |player_params|
          team.players.create!(
            nickname: player_params[:nickname],
            name: player_params[:name],
            country: find_country(player_params[:country_name])
          )
        end
      end

      def self.find_country(country_name)
        return nil if country_name.blank?

        ::Countries::FindService.call(country_name)
      end

      def self.handle_error(error)
        record = error.record

        if record.is_a?(Player) && record.errors[:nickname].present?
          return error("Nickname '#{record.nickname}' has already been taken")
        end

        error(record.errors.full_messages.to_sentence)
      end

      def self.success(team)
        { success: true, team: team }
      end

      def self.error(message)
        { success: false, message: message }
      end
    end
  end
end
