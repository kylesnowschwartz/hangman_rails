class GuessesController < ApplicationController
  def create
    # GuessValidator.new(params).call
    @game = Game.find(params[:game_id])

    @guess = @game.guesses.new(letter: guess_params[:letter].upcase)

    unless @guess.save
      flash[:alert] = @guess.errors.full_messages
    end

    redirect_to game_path(@game)
  end

  def guess_params
    params.require(:guess).permit(:letter)
  end
end


# class GuessesController < ApplicationController
#   def create
#     # TODO GuessValidator.new(params).call
#     game = Game.find(params[:game_id])

#     if params[:guess][:letter] && ('A'..'Z').include?(params[:guess][:letter].upcase)
#       game.guesses.create!(letter: params[:guess][:letter].upcase)
#     else
#       flash[:alert] = "You must guess a single letter of the English alphabet."
#     end

#     redirect_to game_path(game)
#   end
# end