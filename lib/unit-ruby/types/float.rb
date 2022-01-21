module Unit
  module Types
    class Float
      def self.cast(value)
        value&.to_f
      end
    end
  end
end
