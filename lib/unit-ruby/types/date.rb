require 'date'

module Unit
  module Types
    class Date
      def self.cast(value)
        return nil if value.nil?
        return value if value.is_a?(::Date)

        ::Date.parse(value)
      end

      def self.as_json_api(value)
        return nil if value.nil?

        value.strftime('%F')
      end
    end
  end
end
