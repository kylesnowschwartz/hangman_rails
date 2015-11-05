class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    @guess = game.guesses.new(guess_params)
    redirect_to game_path(game)
  end


  def guess_params
    params.require(:guess).permit(:letter)
  end
end
