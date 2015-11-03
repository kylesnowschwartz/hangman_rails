require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:word) { "banana" }
  let(:lives) { 1 }
  let(:game) { Game.create(word: word, lives: lives) }

  describe "fields" do
    it { should have_db_column(:word).of_type(:string) }
    it { should have_db_column(:lives).of_type(:integer) }
  end

  describe "validations" do
    it { should validate_presence_of(:lives) }
    it { should validate_numericality_of(:lives).is_greater_than(0) }
  end
end
