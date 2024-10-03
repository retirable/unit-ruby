module Unit
  module Types
    class Limit
      attr_reader :total, :used

      def initialize(total:, used:)
        @total = total
        @used = used || 0
      end

      def remaining
        return nil if total.nil?

        total - used
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          total: val[:total],
          used: val[:used]
        )
      end
    end
  end
end
