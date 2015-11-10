class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = GamePresenter.new(Game.find(params[:id]))
  end

  def new
    @game = Game.new
  end

  def create
    @game = CreateGame.new(game_params).call

    if @game.valid?
      redirect_to @game
    else
      render 'new', status: 400
    end
  end

  private

  def game_params
    params.require(:game).permit(:lives, :word)
  end
end
