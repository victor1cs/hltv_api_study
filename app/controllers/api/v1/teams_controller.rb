module Api
  module V1
    class TeamsController < ApplicationController

      def index
        teams = Team.page(params[:page]).per(params[:per_page])

        render json: teams, status: :ok
      end

      def show
        team = Teams::FindService.call(params[:name])
        if team.present?
          render json: team, status: :ok
        else
          render json: { error: "Team not found" }, status: :not_found
        end
      end

      def players
        team = Teams::FindService.call(params[:name])
        if team.present?
          render json: team.players, status: :ok
        else
          render json: { error: "Team not found" }, status: :not_found
        end
      end
    end
  end
end
