module Unit
  module Types
    class Address
      attr_reader :street, :street2, :city, :state, :postal_code, :country

      def initialize(
        street:,
        city:,
        state:,
        postal_code:,
        country:,
        street2: nil
      )
        @street = street
        @street2 = street2
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
          street2: val[:street2],
          city: val[:city],
          state: val[:state],
          postal_code: val[:postal_code],
          country: val[:country]
        )
      end

      def as_json_api
        {
          street: street,
          street2: street2,
          city: city,
          state: state,
          postal_code: postal_code,
          country: country
        }.compact
      end
    end
  end
end
