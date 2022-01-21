module Unit
  module Types
    class Coordinates
      attr_reader :longitude, :latitude

      def initialize(longitude:, latitude:)
        @longitude = longitude
        @latitude = latitude
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(longitude: val[:longitude], latitude: val[:latitude])
      end

      def as_json_api
        { longitude: longitude, latitude: latitude }
      end
    end
  end
end
