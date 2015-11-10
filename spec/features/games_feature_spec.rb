require 'rails_helper'

RSpec.describe Game do
  let(:game) { Game.create!(lives: 1, word: "BANANA")}
  let(:dictionary) { Dictionary.create!(title: "test dictionary") }

  before do
    dictionary.words.create!(word: "BANANA")
  end

  describe "playing the game" do
    context "with correct guesses" do
      it "starts the game as blank" do
        expect(game).to be_valid
        expect(GamePresenter.new(game).board).to eq(["_", "_", "_", "_", "_", "_"])
        expect(game.guessed_letters).to eq([])
      end

      it "submits three correct guesses and understands when the game is finished" do
        expect{ CreateGuess.new(game, "A").call.save }.to change{ Guess.count }.by 1
        expect(Guess.last.correct_guess?("A")).to be true
        expect(GamePresenter.new(game).board).to eq(["_", "A", "_", "A", "_", "A"])
        expect(game.guessed_letters).to eq(["A"])

        expect{ CreateGuess.new(game, "B").call.save }.to change{ Guess.count }.by 1
        expect(Guess.last.correct_guess?("B")).to be true
        expect(GamePresenter.new(game).board).to eq(["B", "A", "_", "A", "_", "A"])
        expect(game.guessed_letters).to eq(["A", "B"])

        expect{ CreateGuess.new(game, "N").call.save }.to change{ Guess.count }.by 1
        expect(Guess.last.correct_guess?("N")).to be true
        expect(GamePresenter.new(game).board).to eq(["B", "A", "N", "A", "N", "A"])
        expect(game.guessed_letters).to eq(["A", "B", "N"])

        expect(game.lives_remaining).to eq 1
        expect(game.lost?).to be false
        expect(game.finished?).to be true
      end
    end

    context "with incorrect guesses" do
      it "plays and loses the game" do
        expect(game).to be_valid
        expect(GamePresenter.new(game).board).to eq(["_", "_", "_", "_", "_", "_"])
        expect(game.guessed_letters).to eq([])

        expect{ CreateGuess.new(game, "Z").call.save }.to change{ Guess.count }.by 1
        expect(Guess.last.correct_guess?("Z")).to be false
        expect(GamePresenter.new(game).board).to eq(["_", "_", "_", "_", "_", "_"])
        expect(game.guessed_letters).to eq(["Z"])

        expect(game.lives_remaining).to eq 0
        expect(game.lost?).to be true
        expect(game.finished?).to be true
      end
    end
  end
end