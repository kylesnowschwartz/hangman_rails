class GuessValidator < ActiveModel::Validator
  ALPHABET = ('A'..'Z')

  def validate(guess)
    unless ALPHABET.include?(guess.letter)
      guess.errors[:letter] << "You must guess a single letter of the English alphabet."
    end
  end
end
