module Unit
  module Types
    class AchLimits
      attr_reader :daily_debit_limit, :daily_debit_limit_used,
                  :monthly_debit_limit, :monthly_debit_limit_used,
                  :daily_credit_limit, :daily_credit_limit_used,
                  :monthly_credit_limit, :monthly_credit_limit_used

      def initialize(daily_debit_limit:, daily_debit_limit_used:,
                     monthly_debit_limit:, monthly_debit_limit_used:,
                     daily_credit_limit:, daily_credit_limit_used:,
                     monthly_credit_limit:, monthly_credit_limit_used:)
        @daily_debit_limit = daily_debit_limit
        @daily_debit_limit_used = daily_debit_limit_used
        @monthly_debit_limit = monthly_debit_limit
        @monthly_debit_limit_used = monthly_debit_limit_used
        @daily_credit_limit = daily_credit_limit
        @daily_credit_limit_used = daily_credit_limit_used
        @monthly_credit_limit = monthly_credit_limit
        @monthly_credit_limit_used = monthly_credit_limit_used
      end

      def self.cast(val)
        return val if val.is_a? self
        return nil if val.nil?

        new(
          daily_debit_limit: val[:limits][:daily_debit],
          daily_debit_limit_used: val[:totals_daily][:debits],
          monthly_debit_limit: val[:limits][:monthly_debit],
          monthly_debit_limit_used: val[:totals_monthly][:debits],
          daily_credit_limit: val[:limits][:daily_credit],
          daily_credit_limit_used: val[:totals_daily][:credits],
          monthly_credit_limit: val[:limits][:monthly_credit],
          monthly_credit_limit_used: val[:totals_monthly][:credits]
        )
      end
    end
  end
end
