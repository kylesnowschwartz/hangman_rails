class Guess < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :letter, presence: true, length: { is: 1 }
  validates_with GuessValidator

  def correct_guess?(guess)
    game.letters.include?(guess)
  end
end
