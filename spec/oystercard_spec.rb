require 'oystercard'

describe Oystercard do

    context "Card balance" do

    it "checks the balance on the card is 0" do
        expect( subject.balance ).to eq 0
      end

    it "adds '20' to the card balance" do
      expect{ subject.top_up(20) }.to change{ subject.balance }.by(20)
    end

    it "is deducted by the minimum fare when touch_out is called" do
      subject.top_up(20)
      subject.touch_in
      expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

  end

  context "knows when it is on a journey" do

    it "can touch in" do
      subject.top_up(1)
      expect(subject).to respond_to(:touch_in)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end

    it "can touch out" do
      expect(subject).to respond_to(:touch_out)
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end
  end

  context "exception handling" do
    it "It prevents touch in if the balance is below the #{Oystercard::MINIMUM_FARE} pound minimum, and raises an error" do
    subject.top_up(0.50)
      expect{subject.touch_in}.to raise_error "Your balance is under #{Oystercard::MINIMUM_FARE} pound, please top up first"
    end

    it "cannot top-up to a balance exceeding the limit of #{Oystercard::BALANCE_LIMIT}" do
      limit = Oystercard::BALANCE_LIMIT
      expect{ subject.top_up(limit + 1) }.to raise_error "Maximum balance of #{limit} would be exceeded"
    end
  end
end
