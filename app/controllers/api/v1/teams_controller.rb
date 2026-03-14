module Api
  module V1
    class TeamsController < ApplicationController
      before_action :set_team, only: [:show, :players]

      def index
        teams = Team.page(params[:page]).per(params[:per_page])
        render json: teams, status: :ok
      end

      def show
        render json: @team, status: :ok
      end

      def players
        render json: @team.players, status: :ok
      end

      private

      def set_team
        @team = ::Teams::FindService.call(params[:name])

        return if @team.present?

        render json: { error: "Team not found" }, status: :not_found
      end
    end
  end
end
