class Word < ActiveRecord::Base
  belongs_to :dictionary

  validates_presence_of :word
end
