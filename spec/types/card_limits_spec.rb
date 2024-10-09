require 'spec_helper'

RSpec.describe Unit::Types::CardLimits do
  let(:daily_withdrawal_limit) { 1100 }
  let(:daily_deposit_limit) { 2200 }
  let(:daily_purchase_limit) { 3300 }
  let(:daily_transaction_limit) { 4400 }
  let(:daily_withdrawal_limit_used) { 110 }
  let(:daily_deposit_limit_used) { 220 }
  let(:daily_purchase_limit_used) { 330 }
  let(:daily_transaction_limit_used) { 440 }

  subject do
    described_class.new(
      daily_withdrawal_limit: daily_withdrawal_limit,
      daily_deposit_limit: daily_deposit_limit,
      daily_purchase_limit: daily_purchase_limit,
      daily_transaction_limit: daily_transaction_limit,
      daily_withdrawal_limit_used: daily_withdrawal_limit_used,
      daily_deposit_limit_used: daily_deposit_limit_used,
      daily_purchase_limit_used: daily_purchase_limit_used,
      daily_transaction_limit_used: daily_transaction_limit_used
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.daily_withdrawal_limit).to eq daily_withdrawal_limit
    expect(subject.daily_deposit_limit).to eq daily_deposit_limit
    expect(subject.daily_purchase_limit).to eq daily_purchase_limit
    expect(subject.daily_transaction_limit).to eq daily_transaction_limit
    expect(subject.daily_withdrawal_limit_used).to eq daily_withdrawal_limit_used
    expect(subject.daily_deposit_limit_used).to eq daily_deposit_limit_used
    expect(subject.daily_purchase_limit_used).to eq daily_purchase_limit_used
    expect(subject.daily_transaction_limit_used).to eq daily_transaction_limit_used
  end

  describe '#self.cast' do
    it 'returns the value if it is already a Types::CardLimits instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        limits: {
          daily_withdrawal: daily_withdrawal_limit,
          daily_deposit: daily_deposit_limit,
          daily_purchase: daily_purchase_limit,
          daily_card_transaction: daily_transaction_limit,
        },
        totals_daily: {
          withdrawals: daily_withdrawal_limit_used,
          deposits: daily_deposit_limit_used,
          purchases: daily_purchase_limit_used,
          card_transactions: daily_transaction_limit_used
        },
      )

      expect(instance.daily_withdrawal_limit).to eq 1100
      expect(instance.daily_deposit_limit).to eq 2200
      expect(instance.daily_purchase_limit).to eq 3300
      expect(instance.daily_transaction_limit).to eq 4400
      expect(instance.daily_withdrawal_limit_used).to eq 110
      expect(instance.daily_deposit_limit_used).to eq 220
      expect(instance.daily_purchase_limit_used).to eq 330
      expect(instance.daily_transaction_limit_used).to eq 440
    end
  end
end
