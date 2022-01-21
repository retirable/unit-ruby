module Unit
  module Types
    class Phone
      attr_reader :country_code, :number

      def initialize(country_code:, number:)
        @country_code = country_code
        @number = number
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(country_code: val[:country_code], number: val[:number])
      end

      def as_json_api
        { country_code: country_code, number: number }
      end
    end
  end
end
