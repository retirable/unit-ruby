module Unit
  module Types
    class Boolean
      def self.cast(value)
        return nil if value.nil?

        case value
        when 'false', '0', 0, false
          false
        when 'true', '1', 1, true
          true
        end
      end
    end
  end
end
