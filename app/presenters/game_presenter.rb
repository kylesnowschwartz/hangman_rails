class GamePresenter
  def initialize(game)
    @game = game
  end

  def update_board
    @game.letters.map { |letter| @game.guessed_letters.include?(letter) ? letter : '_' }
  end
end