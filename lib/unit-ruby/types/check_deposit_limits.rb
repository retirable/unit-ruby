module Unit
  module Types
    class CheckDepositLimits
      attr_reader :daily_deposit_limit, :daily_deposit_limit_used,
                  :monthly_deposit_limit, :monthly_deposit_limit_used

      def initialize(daily_deposit_limit:, daily_deposit_limit_used:, monthly_deposit_limit:, monthly_deposit_limit_used:)
        @daily_deposit_limit = daily_deposit_limit
        @daily_deposit_limit_used = daily_deposit_limit_used
        @monthly_deposit_limit = monthly_deposit_limit
        @monthly_deposit_limit_used = monthly_deposit_limit_used
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          daily_deposit_limit: val[:limits][:daily],
          daily_deposit_limit_used: val[:totals_daily],
          monthly_deposit_limit: val[:limits][:monthly],
          monthly_deposit_limit_used: val[:totals_monthly]
        )
      end
    end
  end
end
