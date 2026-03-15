module Teams
  module Create
    class TeamService
      def self.call(name)
        team = Team.create!(name: name)

        success(team)
      rescue ActiveRecord::RecordInvalid => e
        error(e.record.errors.full_messages.to_sentence)
      end

      def self.success(team)
        { success: true, team: team }
      end

      def self.error(message)
        { success: false, message: message }
      end

      private_class_method :success, :error
    end
  end
end
