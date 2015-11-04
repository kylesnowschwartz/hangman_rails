class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  validates_numericality_of :lives, greater_than: 0, message: "A game cannot be started with zero lives"
  validates_presence_of :lives
  validates_presence_of :word
  validates :word, length: { minimum: 3, too_short: "Please choose a word of 3 or more letters" }
  validate :word_must_be_in_dictionary

  before_create do
    word.upcase!
  end

  def finished?
    zero_lives_remaining? || letters_remaining.empty?
  end

  # class SubmitGuess
  #   def initialize(game, letter_to_guess)
  #     @game = game
  #     @letter_to_guess = letter_to_guess
  #   end

  #   def call
  #     game.guesses.create!(letter: @letter_to_guess)

  #     letters.include?(guess)
  #   end
  # end

  # class GameStatus
  #   def initalize(game)
  #     @game = game
  #   end

  #   def in_progress?
  #     game ....
  #   end

  #   def won?
  #   end

  #   def lost?
  #   end
  # end

  def submit_guess(guess)
    guesses.create(letter: guess)
    letters.include?(guess)
  end

  def zero_lives_remaining?
    lives_remaining == 0
  end

  def lives_remaining # TODO - def incorrect_guesses
    lives - (guessed_letters - letters).count
  end

  def letters_remaining
    letters - guessed_letters
  end

  def board # TODO should be in presenter
    letters.map { |letter| guessed_letters.include?(letter) ? letter : '_' }
  end

  def guessed_letters
    guesses.pluck("letter")
  end

  def random_word
    Dictionary.first.words.all.sample.word
  end

  private

  def word_must_be_in_dictionary
    unless Dictionary.first.words.find_by_word(word.upcase)
      errors.add(:word, "This word is not in your dictionary")
    end
  end

  def letters # TODO make the model more strict on accepting the data
    word.upcase.chars
  end
end
