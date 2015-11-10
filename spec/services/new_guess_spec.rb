require 'rails_helper'

RSpec.describe CreateGuess do
  let(:game) { Game.create!(lives: 1, word: "BANANA") }
  let(:letter) { "B" }

  subject do
    CreateGuess.new(game, letter).call.save
    Guess.last
  end

  before do
    Dictionary.create!(title: "test dictionary").words.create!(word: "BANANA")
  end

  context "given 'B'" do
    it "is a valid guess" do
      expect(subject).to be_valid
    end

    it "creates a guess" do
      expect(subject).to be_persisted
      expect(Guess.last).to eq(subject)
    end
  end
end
