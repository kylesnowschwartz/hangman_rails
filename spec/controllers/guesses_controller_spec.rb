require 'rails_helper'

RSpec.describe GuessesController, type: :controller do
  let(:dictionary) { Dictionary.create(title: "test dictionary") }
  let(:game) { Game.create!(lives: 1, word: word) }
  let(:word) { "WORD" }

  before do
    dictionary.words.create!(word: word)
  end

  describe "#create" do
    before do
      @game = game
      guess_params = { lives: 1, word: word }
      post :create, { game_id: @game.id, guess: guess_params }
    end

    it { should respond_with(302) }
    it "redirects to the current game page" do
      expect(response).to redirect_to("/games/#{game.id}")
    end
  end
end
