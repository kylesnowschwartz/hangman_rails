class Dictionary < ActiveRecord::Base
  has_many :words, dependent: :destroy

   def self.random_word
    first.words.order("RANDOM()").first.word
  end
end
