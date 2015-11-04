class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  validates_numericality_of :lives, greater_than: 0, message: "A game cannot be started with zero lives"
  validates_presence_of :lives
  validates_presence_of :word
  validates :word, length: { minimum: 3, too_short: "Please choose a word of 3 or more letters" }
  validate :word_must_be_in_dictionary

  before_create do
    self.word.upcase!
  end

  def finished?
    zero_lives_remaining? || letters_remaining.empty?
  end

  def submit_guess(guess)
    self.guesses.create(letter: guess)
    letters.include?(guess)
  end

  def zero_lives_remaining?
    lives_remaining == 0
  end

  def lives_remaining
    self.lives - (guessed_letters - letters).count
  end

  def letters_remaining
    letters - guessed_letters
  end

  def board # should be in presenter
    tiles = letters.map { "_" }

    guessed_letters.each do |letter|
      all_indexes_for_letter(letter).each do |index|
        letters.include?(letter) ? tiles[index] = letter : "_"
      end
    end

    tiles
  end

  def guessed_letters
    self.guesses.pluck("letter")
  end

  def random_word
    Dictionary.first.words.all.sample.word
  end

  private

  def word_must_be_in_dictionary
    unless Dictionary.first.words.find_by_word(self.word.upcase)
      errors.add(:word, "This word is not in your dictionary")
    end
  end

  def all_indexes_for_letter(letter) # presenter with board
    letters.each_index.select { |index| letters[index] == letter } # returns all indicies of given letter if there are duplicates, not just the first index
  end

  def letters # make the model more strict on accepting the data
    self.word.upcase.chars
  end
end
