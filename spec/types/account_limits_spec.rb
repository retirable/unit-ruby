require 'spec_helper'

RSpec.describe Unit::Types::AccountLimits do
  let(:ach_limits) { instance_double(Unit::Types::AchLimits) }
  let(:card_limits) { instance_double(Unit::Types::CardLimits) }
  let(:check_deposit_limits) { instance_double(Unit::Types::CheckDepositLimits) }

  subject do
    described_class.new(
      ach_limits: ach_limits,
      card_limits: card_limits,
      check_deposit_limits: check_deposit_limits
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.ach_limits).to eq ach_limits
    expect(subject.card_limits).to eq card_limits
    expect(subject.check_deposit_limits).to eq check_deposit_limits
  end

  describe '#self.cast' do
    let(:ach_limits_json) { 'ach_limits_json' }
    let(:card_limits_json) { 'card_limits_json' }
    let(:check_deposit_limits_json) { 'check_deposit_limits_json' }

    before do
      allow(Unit::Types::AchLimits)
        .to receive(:cast)
        .with(ach_limits_json)
        .and_return(ach_limits)
      allow(Unit::Types::CardLimits)
        .to receive(:cast)
        .with(card_limits_json)
        .and_return(card_limits)
      allow(Unit::Types::CheckDepositLimits)
        .to receive(:cast)
        .with(check_deposit_limits_json)
        .and_return(check_deposit_limits)
    end

    it 'returns the value if it is already a Types::AccountLimits instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        attributes: {
          ach: ach_limits_json,
          card: card_limits_json,
          check_deposit: check_deposit_limits_json
        }
      )

      expect(instance.ach_limits).to eq ach_limits
      expect(instance.card_limits).to eq card_limits
      expect(instance.check_deposit_limits).to eq check_deposit_limits
    end
  end
end
