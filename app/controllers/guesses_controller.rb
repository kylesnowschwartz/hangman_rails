class GuessesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    @guess = CreateGuess.new(@game, guess_params[:letter]).call

    unless @guess.valid?
      flash[:alert] = @guess.errors.full_messages
    end

    redirect_to @game
  end

  def guess_params
    params.require(:guess).permit(:letter)
  end
end