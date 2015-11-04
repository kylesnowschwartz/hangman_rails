class WordValidator < ActiveModel::Validator
  def validate(word)
    unless Dictionary.first.words.find_by_word!(word)
      word.errors[:word] << "This is not a valid word in your dictionary"
    end
  end
end