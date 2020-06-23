class GamesController < ApplicationController
  def index
    @games = Game.sorted

    sleep 2

    render json: @games.as_json(methods: :status)
  end
end
