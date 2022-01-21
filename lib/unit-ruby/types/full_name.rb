module Unit
  module Types
    class FullName
      attr_reader :first, :last

      def initialize(first:, last:)
        @first = first
        @last = last
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(first: val[:first], last: val[:last])
      end

      def as_json_api
        { first: first, last: last }
      end
    end
  end
end
