require 'rails_helper'

RSpec.describe Game do
  let(:game) { Game.create!(lives: 1, word: "BANANA")}
  let(:dictionary) { Dictionary.create(title: "test dictionary") }

  before do
    dictionary.words.create!(word: "BANANA")
  end

  describe "playing the game" do
    it "plays the game with correct guesses" do
      expect(game).to be_valid
      expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
      expect(game.guessed_letters).to eq([])

      expect(game.submit_guess("A")).to be true
      expect(game.board).to eq(["_", "A", "_", "A", "_", "A"])
      expect(game.guessed_letters).to eq(["A"])

      expect(game.submit_guess("B")).to be true
      expect(game.board).to eq(["B", "A", "_", "A", "_", "A"])
      expect(game.guessed_letters).to eq(["A", "B"])

      expect(game.submit_guess("N")).to be true
      expect(game.board).to eq(["B", "A", "N", "A", "N", "A"])
      expect(game.guessed_letters).to eq(["A", "B", "N"])

      expect(game.lives_remaining).to eq 1
      expect(game.zero_lives_remaining?).to be false
      expect(game.finished?).to be true
    end

    it "plays the game with incorrect guesses" do
      expect(game).to be_valid
      expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
      expect(game.guessed_letters).to eq([])

      expect(game.submit_guess("Z")).to be false
      expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
      expect(game.guessed_letters).to eq(["Z"])

      expect(game.lives_remaining).to eq 0
      expect(game.zero_lives_remaining?).to be true
      expect(game.finished?).to be true
    end
  end
end