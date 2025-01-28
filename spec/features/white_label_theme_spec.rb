require 'spec_helper'

RSpec.describe Unit::WhiteLabelTheme do
  before do
    establish_connection_to_api!
  end

  after do
    Unit::WhiteLabelTheme
      .find(ENV.fetch('UNIT_THEME_ID'))
      .save_config(JSON.parse(fixture('theme_initial.json').read))
  end

  it 'updates a theme' do
    theme = Unit::WhiteLabelTheme.find(ENV.fetch('UNIT_THEME_ID', nil))
    initial_theme_configuration = theme.raw_data[:attributes]

    expect(initial_theme_configuration[:name]).to eq('Unit-Ruby Specs Default Theme')
    expect(initial_theme_configuration[:global][:logo_url]).to eq('https://app.s.unit.sh/logo-dark.f1c96208.svg')

    theme.save_config(JSON.parse(fixture('theme_updated.json').read))

    theme = Unit::WhiteLabelTheme.find(ENV.fetch('UNIT_THEME_ID', nil))
    updated_theme_configuration = theme.raw_data[:attributes]

    expect(updated_theme_configuration[:name]).to eq('Unit-Ruby Specs Updated Theme')
    expect(updated_theme_configuration[:global][:logo_url]).to eq('https://some-other-logo.svg')
  end
end
