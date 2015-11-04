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
      5.times { game }
      get :index
    end

    it { should respond_with(200) }
    it { should render_template(:index) }
    it "should assign @games to all Games in DB" do
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
    it "should assign game to specified id to @game" do
      expect(assigns(:game)).to eq(@game)
    end
  end

  describe "#create" do
  end

  describe "#destroy" do
  end
end
