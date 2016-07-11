require 'oystercard'

describe Oystercard do
  subject( :card ) { Oystercard.new }

  describe "the balance on a new oystercard"
    it "checks the balance on the card is 0" do
        expect(card.balance).to eq 0
      end
end
