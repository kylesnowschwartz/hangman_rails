require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:lives) { 1 }
  let(:word) { "BANANA" }
  let(:game) { Game.create(lives: lives, word: word) }
  let(:dictionary) { Dictionary.create(title: "test dictionary") }

  before do
    dictionary.words.create!(word: "BANANA")
  end

  describe "#index" do
    before do 
      5.times { Game.create(lives: lives, word: word) }
      get :index
    end

    it 'has 5 games' do
      expect(Game.all.count).to eq 5
    end

    it { should respond_with(200) }
    it { should render_template(:index) }
    it "assigns @games to all Games in DB" do
      expect(assigns(:games)).to eq(Game.all)
    end
  end

  describe "#show" do
    before do
      @game = game
      get :show, id: @game.id
    end

    it { should respond_with(200) }
    it { should render_template(:show) }
    it "assigns game to specified id to @game" do
      expect(assigns(:game)).to eq(@game)
    end
  end

  describe "#new" do
    before do
      get :new
    end

    it { should respond_with(200) }
    it { should render_template(:new) }
  end

  describe "#create" do
    context "valid params" do
      before do
        @game_params = { lives: lives, word: word }
        post :create, { game: @game_params }
      end

      it { should respond_with(302) }
      it "redirects to the new game's page" do
        game = Game.find_by(@game_params)
        expect(response).to redirect_to("/games/#{game.id}")
      end
      it "creates a new game with specified params" do
        expect(Game.find_by(@game_params)).to be_truthy
      end
    end

    context "invalid params" do
      before do
        @invalid_game_params = { lives: 0, word: 1 }
        post :create, { game: @invalid_game_params }
      end

      it { should respond_with(400) }
      it { should render_template(:new) }
      it "does not create a new game" do
        expect(Game.find_by(@invalid_game_params)).to be_nil
      end
    end
  end

  describe "#destroy" do
  end
end
