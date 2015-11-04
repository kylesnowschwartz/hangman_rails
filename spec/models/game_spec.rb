require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:word) { "BANANA" }
  let(:lives) { 1 }
  let(:game) { Game.create(word: word, lives: lives) }
  let(:correct_guess) { Guess.create(letter: "A", game: game) }
  let(:incorrect_guess) { Guess.create(letter: "Z", game: game) }
  let(:invalid_guess) { Guess.create(letter: 1, game: game) }
  let(:dictionary) { Dictionary.create(title: "test dictionary") }

  before do
    dictionary.words.create!(word: "BANANA")
  end

  describe "fields" do
    it { should have_db_column(:word).of_type(:string) }
    it { should have_db_column(:lives).of_type(:integer) }
  end

  describe "#create" do
    context "with a correct arguments" do
      it "sets #lives_remaining to the correct number of lives" do
        expect(game.lives_remaining).to eq 1
      end

      it "sets #guessed_letters to an empty array" do
        expect(game.guessed_letters).to eq([])
      end

      it "sets #board to an array of underscores" do
        expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
      end
    end

    xcontext "with an incorrect arguments" do
      it "raises an error when given 0 lives" do
        expect { Game.create!(lives: 0, word: "BOTTLE") }.to raise_error("A game cannot be started with zero lives")
      end

      it "raises an error when given a word not in the dictionary" do
        expect { Game.create!(lives: lives, word: "ASDF123") }.to raise_error("This word is not in your dictionary")
      end

      it "raises an error when given a word less than 3 letters long" do
        expect { Game.create!(lives: 3, word: "AT") }.to raise_error("Please choose a word of 3 or more letters")
      end
    end
  end

  describe "#finished?" do
    context "with lives remaining" do
      it "returns false" do
        expect(game.finished?).to be false
      end
    end

    context "with no lives remaining" do
      before do
        game.submit_guess("Z")
      end
      
      it "returns true" do
        expect(game.finished?).to be true
      end
    end
  end

  describe "#board" do
    context "with correct letter" do
      it "replaces a blank tile" do
        game.submit_guess("B")
        expect(game.board).to eq(["B", "_", "_", "_", "_", "_"])
      end
    end

    context "with incorrect letter" do
      it "does not replace a blank tile" do
        game.submit_guess("Z")
        expect(game.board).to eq(["_", "_", "_", "_", "_", "_"])
      end
    end

    describe "#submit_guess" do
      context "with a correct guess" do
        it "returns true" do
          expect(game.submit_guess("B")).to be true
        end
      end

      context "with a incorrect guess" do
        it "returns false" do
          expect(game.submit_guess("Q")).to be false
        end
      end
    end
  end
end
