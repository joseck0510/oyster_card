require 'journey'
describe Journey do
let(:station) {double :station, zone: 1}
context "given an entry station" do
  subject {described_class.new(entry_station: station)}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  it "has a penalty fare by default" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when finishing a journey" do
    expect(subject.finish(station)).to eq(subject)
  end

  it "has an entry station" do
      expect(subject.entry_station).to eq station
  end

  it "returns minimum fare if exit station given" do
    subject.finish(station)
    expect(subject.fare).to eq Journey::MINIMUM_FARE
  end

  it "returns penalty fare if no exit given" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end 


  end


end
