class CreateGame
  def initialize(params)
    @lives = params[:lives]
    @word = params[:word]
  end

  def call
    word = @word.blank? ? Dictionary.random_word : @word
    Game.create(lives: @lives, word: word.upcase)
  end
end