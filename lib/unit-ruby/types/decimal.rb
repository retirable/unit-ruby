module Unit
  module Types
    class Decimal
      def self.cast(value)
        value&.to_d
      end
    end
  end
end
