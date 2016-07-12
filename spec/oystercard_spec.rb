require 'oystercard'

describe Oystercard do
  subject( :card ) { Oystercard.new }

    context "Card balance" do

    it "checks the balance on the card is 0" do
        expect( card.balance ).to eq 0
      end

    it "adds '20' to the card balance" do
      expect{ card.top_up(20) }.to change{ card.balance }.by(20)
    end
  end
end
