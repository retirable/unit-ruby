require 'spec_helper'

RSpec.describe Unit::WhiteLabelTheme do
  before do
    establish_connection_to_api!
  end

  def update_theme(fixture_name)
    Unit::WhiteLabelTheme.find(ENV.fetch('UNIT_THEME_ID')).tap do |theme|
      theme.replace_json(
        fixture(fixture_name).read
      )
    end
  end

  it 'updates a theme' do
    initial_theme = update_theme('theme_initial.json')
    initial_theme_attributes = initial_theme.raw_data[:attributes]

    expect(initial_theme_attributes[:name])
      .to eq('Unit-Ruby Specs Default Theme')
    expect(initial_theme_attributes[:global][:logo_url])
      .to eq('https://app.s.unit.sh/logo-dark.f1c96208.svg')

    updated_theme = update_theme('theme_updated.json')
    updated_theme_attributes = updated_theme.raw_data[:attributes]

    expect(updated_theme_attributes[:name])
      .to eq('Unit-Ruby Specs Updated Theme')
    expect(updated_theme_attributes[:global][:logo_url])
      .to eq('https://some-other-logo.svg')
  end
end
