class CreateGuess
  def initialize(game, letter)
    @letter = letter
    @game = game
  end

  def call
    Guess.create(game: @game, letter: @letter.upcase)
  end
end