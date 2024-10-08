module Unit
  module Types
    class CardLimits
      attr_reader :daily_withdrawal_limit, :daily_withdrawal_limit_used,
                  :daily_deposit_limit, :daily_deposit_limit_used,
                  :daily_purchase_limit, :daily_purchase_limit_used,
                  :daily_transaction_limit, :daily_transaction_limit_used

      def initialize(daily_withdrawal_limit:, daily_withdrawal_limit_used:,
                     daily_deposit_limit:, daily_deposit_limit_used:,
                     daily_purchase_limit:, daily_purchase_limit_used:,
                     daily_transaction_limit:, daily_transaction_limit_used:)
        @daily_withdrawal_limit = daily_withdrawal_limit
        @daily_withdrawal_limit_used = daily_withdrawal_limit_used
        @daily_deposit_limit = daily_deposit_limit
        @daily_deposit_limit_used = daily_deposit_limit_used
        @daily_purchase_limit = daily_purchase_limit
        @daily_purchase_limit_used = daily_purchase_limit_used
        @daily_transaction_limit = daily_transaction_limit
        @daily_transaction_limit_used = daily_transaction_limit_used
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          daily_withdrawal_limit: val[:limits][:daily_withdrawal],
          daily_withdrawal_limit_used: val[:totals_daily][:withdrawals],
          daily_deposit_limit: val[:limits][:daily_deposit],
          daily_deposit_limit_used: val[:totals_daily][:deposits],
          daily_purchase_limit: val[:limits][:daily_purchase],
          daily_purchase_limit_used: val[:totals_daily][:purchases],
          daily_transaction_limit: val[:limits][:daily_card_transaction],
          daily_transaction_limit_used: val[:totals_daily][:card_transactions]
        )
      end
    end
  end
end
