require 'spec_helper'

RSpec.describe Unit::Types::AchLimits do
  let(:daily_debit_limit) { 1100 }
  let(:daily_credit_limit) { 2200 }
  let(:monthly_debit_limit) { 3300 }
  let(:monthly_credit_limit) { 4400 }
  let(:daily_debit_used) { 110 }
  let(:daily_credit_used) { 220 }
  let(:monthly_debit_used) { 330 }
  let(:monthly_credit_used) { 440 }

  subject do
    described_class.new(
      daily_debit_limit: daily_debit_limit,
      daily_credit_limit: daily_credit_limit,
      monthly_debit_limit: monthly_debit_limit,
      monthly_credit_limit: monthly_credit_limit,
      daily_debit_limit_used: daily_debit_used,
      daily_credit_limit_used: daily_credit_used,
      monthly_debit_limit_used: monthly_debit_used,
      monthly_credit_limit_used: monthly_credit_used
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.daily_debit_limit).to eq daily_debit_limit
    expect(subject.daily_credit_limit).to eq daily_credit_limit
    expect(subject.monthly_debit_limit).to eq monthly_debit_limit
    expect(subject.monthly_credit_limit).to eq monthly_credit_limit
    expect(subject.daily_debit_limit_used).to eq daily_debit_used
    expect(subject.daily_credit_limit_used).to eq daily_credit_used
    expect(subject.monthly_debit_limit_used).to eq monthly_debit_used
    expect(subject.monthly_credit_limit_used).to eq monthly_credit_used
  end

  describe '#self.cast' do
    it 'returns the value if it is already a Types::AchLimits instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        limits: {
          daily_debit: daily_debit_limit,
          daily_credit: daily_credit_limit,
          monthly_debit: monthly_debit_limit,
          monthly_credit: monthly_credit_limit,
        },
        totals_daily: {
          debits: daily_debit_used,
          credits: daily_credit_used
        },
        totals_monthly: {
          debits: monthly_debit_used,
          credits: monthly_credit_used
        }
      )

      expect(instance.daily_debit_limit).to eq 1100
      expect(instance.daily_credit_limit).to eq 2200
      expect(instance.monthly_debit_limit).to eq 3300
      expect(instance.monthly_credit_limit).to eq 4400
      expect(instance.daily_debit_limit_used).to eq 110
      expect(instance.daily_credit_limit_used).to eq 220
      expect(instance.monthly_debit_limit_used).to eq 330
      expect(instance.monthly_credit_limit_used).to eq 440
    end
  end
end
