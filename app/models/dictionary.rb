class Dictionary < ActiveRecord::Base
  has_many :words, dependent: :destroy

  def self.random_word
  # TODO in development the first dictionary is the default dictionary
    first.words.order("RANDOM()").first.word
  end
end
