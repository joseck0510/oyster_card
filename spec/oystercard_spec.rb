require 'oystercard'

describe Oystercard do

    context "Card balance" do

    it "checks the balance on the card is 0" do
        expect( subject.balance ).to eq 0
      end

    it "adds '20' to the card balance" do
      expect{ subject.top_up(20) }.to change{ subject.balance }.by(20)
    end

    it "cannot top-up to a balance exceeding the limit of #{Oystercard::BALANCE_LIMIT}" do
      limit = Oystercard::BALANCE_LIMIT
      expect{ subject.top_up(limit + 1) }.to raise_error "Maximum balance of #{limit} would be exceeded"
    end

    it "checks that a fare of 5 is deducted from card balance" do
      subject.top_up(20)
      expect{ subject.deduct(5) }.to change{ subject.balance }.by(-5)
    end

  end

  context "knows when it is on a journey" do

    it "can touch in" do
      expect(subject).to respond_to(:touch_in)
      expect(subject.touch_in).to eq(subject.in_journey?)

    end

    it "can touch out" do
      expect(subject).to respond_to(:touch_out)
      subject.touch_out
      expect(subject.in_journey?).to eq(false)

    end



  end
end
