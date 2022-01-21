module Unit
  module Types
    class ApplicationFormSettingsOverride
      attr_reader :redirect_url, :privacy_policy_url, :electronic_disclosures_url,
                  :deposit_terms_url, :client_terms_url, :cardholder_terms_url, :cash_advanced_terms_url, :additional_disclosures

      def initialize(
        redirect_url: nil,
        privacy_policy_url: nil,
        electronic_disclosures_url: nil,
        deposit_terms_url: nil,
        client_terms_url: nil,
        cardholder_terms_url: nil,
        cash_advanced_terms_url: nil,
        additional_disclosures: nil
      )
        @redirect_url = redirect_url
        @privacy_policy_url = privacy_policy_url
        @electronic_disclosures_url = electronic_disclosures_url
        @deposit_terms_url = deposit_terms_url
        @client_terms_url = client_terms_url
        @cardholder_terms_url = cardholder_terms_url
        @cash_advanced_terms_url = cash_advanced_terms_url
        @additional_disclosures = additional_disclosures
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          redirect_url: val[:redirect_url],
          privacy_policy_url: val[:privacy_policy_url],
          electronic_disclosures_url: val[:electronic_disclosures_url],
          deposit_terms_url: val[:deposit_terms_url],
          client_terms_url: val[:client_terms_url],
          cardholder_terms_url: val[:cardholder_terms_url],
          cash_advanced_terms_url: val[:cash_advanced_terms_url],
          additional_disclosures: val[:additional_disclosures]
        )
      end

      def as_json_api
        {
          redirect_url: redirect_url,
          privacy_policy_url: privacy_policy_url,
          electronic_disclosures_url: electronic_disclosures_url,
          deposit_terms_url: deposit_terms_url,
          client_terms_url: client_terms_url,
          cardholder_terms_url: cardholder_terms_url,
          cash_advanced_terms_url: cash_advanced_terms_url,
          additional_disclosures: additional_disclosures
        }
      end
    end
  end
end
