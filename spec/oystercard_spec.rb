require 'oystercard'

describe Oystercard do

    context "Card balance" do

    it "checks the balance on the card is 0" do
        expect( subject.balance ).to eq 0
      end

    it "adds '20' to the card balance" do
      expect{ subject.top_up(20) }.to change{ subject.balance }.by(20)
    end
  end
end
