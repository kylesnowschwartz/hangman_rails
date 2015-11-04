class Guess < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :letter, presence: true, length: { is: 1 }
  validates_with GuessValidator
end
