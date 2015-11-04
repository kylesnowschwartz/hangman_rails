require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:game) { Game.create!(lives: 1, word: "BANANA") }
  let(:character) { "A" }
  let(:guess) { Guess.create!(game: game, letter: character) }
  let(:invalid_guess) { Guess.new(game: game, letter: character) }

  before do
    dictionary = Dictionary.create!(title: "Test Dictionary")
    word = dictionary.words.create!(word: "BANANA")
  end

  describe "#create" do
    context "guess an uppercase letter in the alphabet" do
      it "creates a valid guess" do
        expect(guess).to be_valid
      end
    end

    context "guess a lowercase letter in the alphabet" do
      let(:character) { "a" }
      it "creates a valid guess" do
        expect(guess).to be_valid
      end
    end

    context "invalid guess" do
      let(:character) { "az" }

      it "raises an error if you guess two letters character" do
        @invalid_guess = invalid_guess
        @invalid_guess.validate
        expect(@invalid_guess.errors[:letter]).to include("You must guess a single letter of the English alphabet.")
      end
    end
  end
end
