require 'spec_helper'

RSpec.describe Unit::WhiteLabelLanguage do
  before do
    establish_connection_to_api!
  end

  after do
    Unit::WhiteLabelLanguage
      .find(ENV.fetch('UNIT_LANGUAGE_ID'))
      .save_config(JSON.parse(fixture('language_initial.json').read))
  end

  it 'updates a language' do
    language = Unit::WhiteLabelLanguage.find(ENV.fetch('UNIT_LANGUAGE_ID', nil))
    initial_language_configuration = language.raw_data[:attributes]

    expect(initial_language_configuration[:name]).to eq('Unit-Ruby Specs English Language Config')
    expect(initial_language_configuration[:global][:months]).to eq(
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

    language.save_config(JSON.parse(fixture('language_updated.json').read))

    language = Unit::WhiteLabelLanguage.find(ENV.fetch('UNIT_LANGUAGE_ID', nil))
    updated_language_configuration = language.raw_data[:attributes]

    expect(updated_language_configuration[:name]).to eq(
      'Unit-Ruby Specs Updated English Language Config'
    )
    expect(updated_language_configuration[:global][:months]).to eq(
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
