require 'date'

module Unit
  module Types
    class Date
      def self.cast(value)
        return nil if value.nil?

        ::Date.parse(value).strftime('%F')
      end
    end
  end
end
