require 'spec_helper'

RSpec.describe Unit::Types::Schedule do
  let(:start_time) { Date.parse('2022-06-29') }
  let(:end_time) { Date.parse('2026-06-30') }
  let(:interval) { 'Monthly' }
  let(:day_of_month) { -1 }
  let(:day_of_week) { nil }
  let(:total_number_of_payments) { nil }

  subject do
    described_class.new(
      start_time: start_time,
      end_time: end_time,
      interval: interval,
      day_of_month: day_of_month,
      day_of_week: day_of_week,
      total_number_of_payments: total_number_of_payments
    )
  end

  it 'instantiates an instance of the type' do
    expect(subject.start_time).to eq start_time
    expect(subject.end_time).to eq end_time
    expect(subject.interval).to eq interval
    expect(subject.day_of_month).to eq day_of_month
    expect(subject.day_of_week).to eq day_of_week
    expect(subject.total_number_of_payments).to eq total_number_of_payments
  end

  describe '#self.cast' do
    let(:new_start_time) { '2023-06-14' }
    let(:new_end_time) { '2028-06-14' }
    let(:new_interval) { 'Weekly' }
    let(:new_day_of_month) { nil }
    let(:new_day_of_week) { 5 }
    let(:new_total_number_of_payments) { 52 }

    it 'returns the value if it is already a Types::Schedule instance' do
      expect(described_class.cast(subject)).to eq subject
    end

    it 'returns nil if the value is nil' do
      expect(described_class.cast(nil)).to eq nil
    end

    it 'instantiates a new instance with the provided attributes' do
      instance = described_class.cast(
        {
          start_time: new_start_time,
          end_time: new_end_time,
          interval: new_interval,
          day_of_month: new_day_of_month,
          day_of_week: new_day_of_week,
          total_number_of_payments: new_total_number_of_payments
        }
      )

      expect(instance.start_time).to eq Date.parse(new_start_time)
      expect(instance.end_time).to eq Date.parse(new_end_time)
      expect(instance.interval).to eq new_interval
      expect(instance.day_of_month).to eq new_day_of_month
      expect(instance.day_of_week).to eq new_day_of_week
      expect(instance.total_number_of_payments).to eq new_total_number_of_payments
    end
  end

  describe '#as_json_api' do
    it 'returns a hash with the correct non-nil attributes' do
      expect(subject.as_json_api).to eq(
        {
          start_time: '2022-06-29',
          end_time: '2026-06-30',
          interval: 'Monthly',
          day_of_month: -1
        }
      )
    end
  end
end
