module Unit
  module Types
    class Counterparty
      attr_reader :routing_number, :account_number, :account_type, :name

      def initialize(routing_number:, account_number:, account_type:, name:)
        @routing_number = routing_number
        @account_number = account_number
        @account_type = account_type
        @name = name
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          routing_number: val[:routing_number],
          account_number: val[:account_number],
          account_type: val[:account_type],
          name: val[:name]
        )
      end

      def as_json_api
        {
          routing_number: routing_number,
          account_number: account_number,
          account_type: account_type,
          name: name
        }
      end
    end
  end
end
