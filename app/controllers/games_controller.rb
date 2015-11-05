class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    # TODO game presenter takes the game
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render 'new', status: 400
    end
  end

  private

  def game_params
    params.require(:game).permit(:lives, :word)
  end
end
