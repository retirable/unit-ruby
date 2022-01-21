module Unit
  module Types
    class Address
      attr_reader :street, :city, :state, :postal_code, :country

      def initialize(street:, city:, state:, postal_code:, country:)
        @street = street
        @city = city
        @state = state
        @postal_code = postal_code
        @country = country
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          street: val[:street],
          city: val[:city],
          state: val[:state],
          postal_code: val[:postal_code],
          country: val[:country]
        )
      end

      def as_json_api
        { street: street, city: city, state: state, postal_code: postal_code, country: country }
      end
    end
  end
end
