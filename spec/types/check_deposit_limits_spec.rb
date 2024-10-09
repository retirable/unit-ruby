require 'spec_helper'

RSpec.describe Unit::Types::CheckDepositLimits do
  let(:daily_limit) { 1100 }
  let(:monthly_limit) { 2200 }
  let(:daily_used) { 110 }
  let(:monthly_used) { 220 }

  subject do
    described_class.new(
      daily_deposit_limit: daily_limit,
      daily_deposit_limit_used: daily_used,
      monthly_deposit_limit: monthly_limit,
      monthly_deposit_limit_used: monthly_used
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.daily_deposit_limit).to eq daily_limit
    expect(subject.daily_deposit_limit_used).to eq daily_used
    expect(subject.monthly_deposit_limit).to eq monthly_limit
    expect(subject.monthly_deposit_limit_used).to eq monthly_used
  end

  describe '#self.cast' do
    it 'returns the value if it is already a Types::CheckDepositLimits instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        limits: {
          daily: daily_limit,
          monthly: monthly_limit,
        },
        totals_daily: daily_used,
        totals_monthly: monthly_used
      )

      expect(instance.daily_deposit_limit).to eq daily_limit
      expect(instance.monthly_deposit_limit).to eq monthly_limit
      expect(instance.daily_deposit_limit_used).to eq daily_used
      expect(instance.monthly_deposit_limit_used).to eq monthly_used
    end
  end
end
