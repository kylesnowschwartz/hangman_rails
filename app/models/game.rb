class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy
  # TODO perhaps there should be a many to many relationship between word and game models, so as to not save this piece of data twice
  validates_numericality_of :lives, greater_than: 0, message: "A game cannot be started with zero lives"
  validates_presence_of :lives
  validates_presence_of :word
  validates :word, length: { minimum: 3, too_short: "Please choose a word of 3 or more letters" }
  validate :word_must_be_in_dictionary

  def finished?
    lost? || letters_remaining.empty?
  end

  def lost?
    lives_remaining <= 0
  end

  def lives_remaining
    lives - incorrect_guesses.count
  end
  
  def guessed_letters
    guesses.pluck("letter")
  end

  def letters 
    word.upcase.chars
  end

  private

  def letters_remaining
    letters - guessed_letters
  end

  def incorrect_guesses
    guessed_letters - letters
  end

  def word_must_be_in_dictionary
    unless Dictionary.first.words.find_by_word(word)
      errors.add(:word, "This word is not in your dictionary")
    end
  end
end

  # examples of service model
  #command:
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

  #query:
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

  # def won?
  #   if @game.lost?
  #     @view.report_game_lost
  #   else
  #     @view.report_game_won
  #   end
  # end

  # def take_turn
  #   guess = @view.ask_for_letter
    
  #   if @game.submit_guess(guess)
  #     @view.report_correct_guess
  #   else
  #     @view.report_incorrect_guess
  #   end
  # end