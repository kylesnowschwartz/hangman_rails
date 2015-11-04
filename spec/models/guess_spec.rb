require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:character) { "A" }
  let(:guess) { Guess.create!(character) }

  context "valid guess" do
    describe "#create" do
      it "should create a valid guess" do
        expect(guess).to be_truthy
      end
    end
  end
end
