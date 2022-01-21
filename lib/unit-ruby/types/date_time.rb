module Unit
  module Types
    class DateTime
      def self.cast(value)
        return nil if value.nil?

        ::Date.parse(value).iso8601
      end
    end
  end
end
