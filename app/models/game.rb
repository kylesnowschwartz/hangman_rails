class Game < ActiveRecord::Base
  has_many :guesses

  validates_numericality_of :lives, greater_than: 0
  validates_presence_of :lives
end
