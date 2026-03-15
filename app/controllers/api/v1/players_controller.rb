module Api
  module V1
    class PlayersController < ApplicationController
      before_action :set_player, only: [:show, :update]

      def index
        players = Player.page(params[:page]).per(params[:per_page])
        render json: players, status: :ok
      end

      def show
        render json: @player, serializer: PlayerSerializer, status: :ok
      end

      def update
        result = ::Players::Update::TeamService.call(@player, permitted_params[:team_name])

        if result[:success]
          render json: { message: result[:message] }, status: :ok
        else
          render json: { error: result[:message] }, status: :unprocessable_entity
        end
      end

      private

      def permitted_params
        params.permit(:team_name)
      end

      def set_player
        @player = ::Players::FindService.call(params[:nickname])

        return if @player.present?

        render json: { error: "Player not found" }, status: :not_found
      end
    end
  end
end
