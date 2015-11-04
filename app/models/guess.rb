class Guess < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :letter, presence: true, length: { is: 1 }
  validates_with GuessValidator

  before_validation do 
    self.letter.upcase!
  end
end


# class CreateGuess
#   def initialize(game, letter)
#     @game = game
#     @letter = letter
#   end

#   def call
#     game.guesses.create!(letter: @letter.upcase)
#   end
# end

# CreateGuess.new(game, params[:letter]).call