module Unit
  module Types
    class Integer
      def self.cast(value)
        value&.to_i
      end
    end
  end
end
