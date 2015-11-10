class GamePresenter
  delegate :guessed_letters, :lives_remaining, :finished?, :word, :id, to: :game

  attr_reader :game

  def initialize(game)
    @game = game
  end

  def board
    @game.letters.map { |letter| @game.guessed_letters.include?(letter) ? letter : '_' }
  end
end