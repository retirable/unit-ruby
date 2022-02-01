RSpec.describe Unit::Util::Error do
  let(:example_api_response) do
    {
      "errors" => [
        {
          "title" => "should be equal to constant",
          "status" => "400",
          "source" => {
            "pointer" => "/data/attributes/address/country"
          },
          "details" => "Field value 'US' is allowed"
        }
      ]
    }
  end

  subject { described_class.new(example_api_response) }

  it 'prints a helpful error message to the logs' do
    expected_log = "Unit::Util::Error: 400 - /data/attributes/address/country - should be equal to constant - Field value 'US' is allowed"

    expect(subject.to_s).to eq(expected_log)
  end
end
