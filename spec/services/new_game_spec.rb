require 'rails_helper'

RSpec.describe CreateGame do
  let(:params) { { lives: 1, word: "BANANA" } }

  subject do 
    CreateGame.new(params).call
  end

  before do
    Dictionary.create!(title: "test dictionary").words.create!(word: "BANANA")
  end

  context "given 'BANANA'" do
    before do
      @game = subject
    end

    it "is a valid game" do
      expect(subject).to be_valid
    end

    it "creates a game" do
      expect(@game).to be_persisted
      expect(@game).to eq(@game)
    end

    it "sets the word to 'BANANA'" do
      expect(@game.word).to eq "BANANA"
    end

    it "sets the correct number of lives" do
      expect(@game.lives).to eq 1
    end
  end

  context "not given a word" do
    let(:params) { { lives: 1, word: "" } }

    before do
      Dictionary.first.words.destroy_all
      Dictionary.first.words.create!(word: "RANDOM")
      @game = subject
    end

    it "is a valid game" do
      expect(subject).to be_valid
    end

    it "creates a game" do
      expect(@game).to be_persisted
      expect(@game).to eq(@game)
    end

    it "sets the word to 'RANDOM'" do
      expect(@game.word).to eq "RANDOM"
    end
  end

  context "given a lowercase word" do
    let(:params) { { lives: 1, word: "TOAST" } }

    before do
      Dictionary.first.words.create!(word: "TOAST")
      @game = subject
    end

    it "is a valid game" do
      expect(subject).to be_valid
    end

    it "creates a game" do
      expect(@game).to be_persisted
      expect(@game).to eq(@game)
    end

    it "sets the word to 'TOAST'" do
      expect(@game.word).to eq "TOAST"
    end

    it "sets the correct number of lives" do
      expect(@game.lives).to eq 1
    end
  end
end