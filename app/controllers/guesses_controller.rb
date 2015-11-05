class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    @guess = game.guesses.new(guess_params)
    if @guess.save!
      redirect_to game_path(game)
    end
    # TODO make this return a 400 and errors
  end


  def guess_params
    params.require(:guess).permit(:letter, :game_id)
  end
end
