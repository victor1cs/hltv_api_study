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

      def create
        result = ::Teams::Create::TeamService.call(
          permitted_params[:name],
          permitted_params[:players]
        )

        if result[:success]
          render json: result[:team], status: :created
        else
          render json: { error: result[:message] }, status: :unprocessable_entity
        end
      end

      def players
        render json: @team.players, each_serializer: TeamPlayerSerializer, status: :ok
      end

      private

      def permitted_params
        params.permit(:name, players: [:nickname, :name, :country_name])
      end

      def set_team
        @team = ::Teams::FindService.call(params[:name])

        return if @team.present?

        render json: { error: "Team not found" }, status: :not_found
      end
    end
  end
end
