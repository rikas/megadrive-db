class GamesController < ApplicationController
  def index
    @games = Game.sorted

    # sleep 2 # uncomment to tweak loaders

    render json: @games.as_json(methods: :status)
  end
end
