module Unit
  module Types
    class WireCounterparty
      attr_reader :routing_number, :account_number, :name, :address

      def initialize(routing_number:, account_number:, name:, address:)
        @routing_number = routing_number
        @account_number = account_number
        @name = name
        @address = address
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          routing_number: val[:routing_number],
          account_number: val[:account_number],
          name: val[:name],
          address: val[:address]
        )
      end

      def as_json_api
        {
          routing_number: routing_number,
          account_number: account_number,
          name: name,
          address: address.as_json_api
        }
      end
    end
  end
end
