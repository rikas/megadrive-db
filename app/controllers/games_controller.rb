class GamesController < ApplicationController
  def index
    @games = Game.sorted

    render json: @games.as_json(methods: :status)
  end
end
