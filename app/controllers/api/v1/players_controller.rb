module Api
  module V1
    class PlayersController < ApplicationController
      before_action :set_player, only: [:show]

      def index
        players = Player.page(params[:page]).per(params[:per_page])
        render json: players, status: :ok
      end

      def show
        render json: @player, each_serializer: PlayerSerializer, status: :ok
      end

      private

      def set_player
        @player = ::Players::FindService.call(params[:nickname])

        return if @player.present?

        render json: { error: "Player not found" }, status: :not_found
      end
    end
  end
end
