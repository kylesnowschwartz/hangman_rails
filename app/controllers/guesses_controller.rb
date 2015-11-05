class GuessesController < ApplicationController
  def create
    # GuessValidator.new(params).call
    @game = Game.find(params[:game_id])
    @guess = @game.guesses.new(guess_params)

    if @guess.save
      redirect_to game_path(@game)
    else
      flash[:alert] = @guess.errors.full_messages
      redirect_to game_path(@game)
    end
  end


  def guess_params
    params.require(:guess).permit(:letter, :game_id)
  end
end
