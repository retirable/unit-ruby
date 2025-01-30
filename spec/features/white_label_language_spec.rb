require 'spec_helper'

RSpec.describe Unit::WhiteLabelLanguage do
  before do
    establish_connection_to_api!
  end

  def update_language(fixture_name)
    Unit::WhiteLabelLanguage.find(ENV.fetch('UNIT_LANGUAGE_ID')).tap do |language|
      language.replace_json(
        fixture(fixture_name).read
      )
    end
  end

  it 'updates a language' do
    initial_language = update_language('language_initial.json')
    initial_language_attributes = initial_language.raw_data[:attributes]

    expect(initial_language_attributes[:name])
      .to eq('Unit-Ruby Specs English Language Config')
    expect(initial_language_attributes[:global][:months])
      .to eq(
        january: 'January',
        february: 'February',
        march: 'March',
        april: 'April',
        may: 'May',
        june: 'June',
        july: 'July',
        august: 'August',
        september: 'September',
        october: 'October',
        november: 'November',
        december: 'December'
      )

    updated_language = update_language('language_updated.json')
    updated_language_attributes = updated_language.raw_data[:attributes]

    expect(updated_language_attributes[:name]).to eq(
      'Unit-Ruby Specs Updated English Language Config'
    )
    expect(updated_language_attributes[:global][:months]).to eq(
      january: 'Janyary',
      february: 'Febby',
      march: 'Myarsh',
      april: 'Ahpreel',
      may: 'Meje',
      june: 'Joone',
      july: 'Judy',
      august: 'Aygist',
      september: 'Septebber',
      october: 'Octopus',
      november: 'Novii',
      december: 'Decembah'
    )
  end
end
