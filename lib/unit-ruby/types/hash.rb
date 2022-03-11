module Unit
  module Types
    class Hash
      attr_reader :items

      def initialize(items)
        @items = items || {}
      end

      def self.cast(val)
        return val if val.is_a? self

        new(val)
      end

      def as_json_api
        items
      end

      delegate :[], to: :items
    end
  end
end
