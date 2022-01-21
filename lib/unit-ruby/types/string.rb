module Unit
  module Types
    class String
      def self.cast(value)
        value&.to_s
      end
    end
  end
end
