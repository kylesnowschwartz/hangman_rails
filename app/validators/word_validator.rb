class WordValidator < ActiveModel::Validator

  def validate(word)
    # the first dictionary is the default in development
    unless Dictionary.first.words.find_by_word!(word)
      errors.add(:word, "This is not a valid word in your dictionary")
    end
  end
end