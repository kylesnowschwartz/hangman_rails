class NewGuess
  def initialize(game, letter)
    @letter = letter
    @game = game
  end

  def call
    normalize_guess
    Guess.new(game: @game, letter: @letter)
  end

  private
  
  def normalize_guess
    @letter.upcase!
  end
end