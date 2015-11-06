require 'rails_helper'

RSpec.describe GuessesController, type: :controller do
  let(:dictionary) { Dictionary.create(title: "test dictionary") }
  let(:game) { Game.create!(lives: 1, word: word) }
  let(:word) { "WORD" }

  before do
    dictionary.words.create!(word: word)
  end

  describe "#create" do
    let(:letter) { 'A' }
    let(:guess_params) { { letter: letter } }

    context "default behavior for valid params" do
      before do
        post :create, { game_id: game.id, guess: guess_params }
      end

      it { should respond_with(302) }
      it "redirects to the current game page" do
        expect(response).to redirect_to("/games/#{game.id}")
      end
    end

    context "with an uppercase letter" do
      let(:letter) { "A" }

      it "creates a guess and saves it to the database" do
        expect{ post :create, { game_id: game.id, guess: guess_params } }. to change{ Guess.count }.by 1
      end
    end

    context "with a lowercase letter" do
      let(:letter) { "a" }

      it "creates a guess and saves it to the database" do
        expect{ post :create, { game_id: game.id, guess: guess_params } }. to change{ Guess.count }.by 1
      end

      it "sets no error for the user" do
        post :create, { game_id: game.id, guess: guess_params }
        expect(flash[:alert]).to eq(nil)
      end
    end

    context "with a number" do
      let(:letter) { "1" }

      it "it doesn't create a guess" do
        expect{ post :create, { game_id: game.id, guess: guess_params } }. to_not change{ Guess.count }
      end

      it "sets an error for the user" do
        post :create, { game_id: game.id, guess: guess_params }
        expect(flash[:alert]).to eq(["Letter You must guess a single letter of the English alphabet."])
      end
    end

    context "with two characters" do
      let(:letter) { "az" }

      it "it doesn't create a guess" do
        expect{ post :create, { game_id: game.id, guess: guess_params } }. to_not change{ Guess.count }
      end

      it "sets an error for the user" do
        post :create, { game_id: game.id, guess: guess_params }
        expect(flash[:alert]).to include("Letter You must guess a single letter of the English alphabet.")
      end
    end     

    context "with a non string" do
      let(:letter) { 1 }

      it "it doesn't create a guess" do
        expect{ post :create, { game_id: game.id, guess: guess_params } }. to_not change{ Guess.count }
      end

      it "sets an error for the user" do
        post :create, { game_id: game.id, guess: guess_params }
        expect(flash[:alert]).to include("Letter You must guess a single letter of the English alphabet.")
      end
    end 
  end
end
