class NewGame
  def initialize(params)
    @lives = params[:lives]
    @word = params[:word]
  end

  def call
    pick_random_word
    normalize_word
    Game.new(lives: @lives, word: @word)
  end

  private

  def pick_random_word
    if @word.blank?
      @word = Dictionary.random_word
    end
  end

  def normalize_word
    @word.upcase!
  end
end