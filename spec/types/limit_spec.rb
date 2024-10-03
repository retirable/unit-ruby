require 'spec_helper'

RSpec.describe Unit::Types::Limit do
  let(:total) { 20_000 }
  let(:used) { 5_000 }

  subject do
    described_class.new(
      total: total,
      used: used
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.total).to eq 20_000
    expect(subject.used).to eq 5_000
    expect(subject.remaining).to eq 15_000
  end

  context 'when remaining is nil' do
    let(:used) { nil }

    it 'returns 0 for used' do
      expect(subject.total).to eq 20_000
      expect(subject.used).to eq 0
      expect(subject.remaining).to eq 20_000
    end
  end

  context 'when total is nil' do
    let(:total) { nil }

    it 'returns nil' do
      expect(subject.total).to eq nil
      expect(subject.used).to eq 5_000
      expect(subject.remaining).to eq nil
    end
  end
end
