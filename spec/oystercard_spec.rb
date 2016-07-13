require 'oystercard'

describe Oystercard do
    let(:station) {double :station}

    context "Card balance" do

    it "checks the balance on the card is 0" do
        expect( subject.balance ).to eq 0
      end

    it "adds '20' to the card balance" do
      expect{ subject.top_up(20) }.to change{ subject.balance }.by(20)
    end

    it "is deducted by the minimum fare when touch_out is called" do
      subject.top_up(20)
      subject.touch_in(station)
      expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end

  context "knows when it is on a journey" do
    it "can touch in" do
      subject.top_up(1)
      expect(subject).to respond_to(:touch_in)
      subject.touch_in(station)
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
      expect{subject.touch_in(station)}.to raise_error "Your balance is under #{Oystercard::MINIMUM_FARE} pound, please top up first"
    end

    it "cannot top-up to a balance exceeding the limit of #{Oystercard::BALANCE_LIMIT}" do
      limit = Oystercard::BALANCE_LIMIT
      expect{ subject.top_up(limit + 1) }.to raise_error "Maximum balance of #{limit} would be exceeded"
    end
  end

  context "recording journeys" do
    it "responds to touch in with one station argument" do
      expect(subject).to respond_to(:touch_in).with(1).arguments
    end
    it "records the entry station of journey" do
      subject.top_up(20)
      subject.touch_in(station)
      expect( subject.entry_station ).to eq(station)
    end
    it "clears entry station on touch out" do
      subject.top_up(20)
      subject.touch_in(station)
      subject.touch_out
      expect( subject.entry_station ).to eq nil
    end
  end

require "oystercard"

describe Oystercard do
let(:station) { double :station }

  it {is_expected.to respond_to(:entry_station) }

  it 'checks to see if the balance is 0' do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    it "top up the balance" do
      expect{ subject.top_up(Oystercard::MINIMUM_FARE) }.to change{ subject.balance }.by(Oystercard::MINIMUM_FARE)
    end
    it "raises error if exceeds the limit" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(Oystercard::MINIMUM_FARE) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe 'status of card' do

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'touch in' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it 'touch out' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

    it "checks balance on touch in" do
      subject.balance < Oystercard::MINIMUM_FARE
      expect{ subject.touch_in(station) }.to raise_error "insufficient funds"
    end

    it 'charge balance on touch out' do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect{ subject.touch_out }.to change{ subject.balance }.by -Oystercard::MINIMUM_FARE
    end

    it "remembers entry station" do
        subject.top_up(Oystercard::MINIMUM_FARE)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
    end
end
