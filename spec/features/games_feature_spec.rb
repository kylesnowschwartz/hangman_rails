require 'rails_helper'

RSpec.describe Game do
  let(:game) { Game.create!(lives: 1, word: "BANANA")}
  let(:dictionary) { Dictionary.create(title: "test dictionary") }

  before do
    dictionary.words.create!(word: "BANANA")
  end

  describe "playing the game" do
    context "with correct guesses" do
      it "starts the game as blank" do
        expect(game).to be_valid
        expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
        expect(game.guessed_letters).to eq([])
      end

      it "submits three correct guesses and understands when the game is finished" do
        expect{ game.submit_guess("A") }.to change{ Guess.count }.by 1
        expect(game.correct_guess?("A")).to be true
        expect(game.board).to eq(["_", "A", "_", "A", "_", "A"])
        expect(game.guessed_letters).to eq(["A"])

        expect{ game.submit_guess("B") }.to change{ Guess.count }.by 1
        expect(game.correct_guess?("B")).to be true
        expect(game.board).to eq(["B", "A", "_", "A", "_", "A"])
        expect(game.guessed_letters).to eq(["A", "B"])

        expect{ game.submit_guess("N") }.to change{ Guess.count }.by 1
        expect(game.correct_guess?("N")).to be true
        expect(game.board).to eq(["B", "A", "N", "A", "N", "A"])
        expect(game.guessed_letters).to eq(["A", "B", "N"])

        expect(game.lives_remaining).to eq 1
        expect(game.zero_lives_remaining?).to be false
        expect(game.finished?).to be true
      end
    end

    context "with incorrect guesses" do
      it "plays and loses the game" do
        expect(game).to be_valid
        expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
        expect(game.guessed_letters).to eq([])

        expect{ game.submit_guess("Z") }.to change{ Guess.count }.by 1
        expect(game.correct_guess?("Z")).to be false
        expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
        expect(game.guessed_letters).to eq(["Z"])

        expect(game.lives_remaining).to eq 0
        expect(game.zero_lives_remaining?).to be true
        expect(game.finished?).to be true
      end
    end
  end
end