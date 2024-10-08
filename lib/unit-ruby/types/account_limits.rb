module Unit
  module Types
    class AccountLimits
      attr_reader :ach_limits, :card_limits, :check_deposit_limits

      def initialize(ach_limits:, card_limits:, check_deposit_limits:)
        @ach_limits = ach_limits
        @card_limits = card_limits
        @check_deposit_limits = check_deposit_limits
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          ach_limits: AchLimits.cast(val[:attributes][:ach]),
          card_limits: CardLimits.cast(val[:attributes][:card]),
          check_deposit_limits: CheckDepositLimits.cast(val[:attributes][:check_deposit])
        )
      end
    end
  end
end
