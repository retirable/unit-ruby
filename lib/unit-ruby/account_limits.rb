module Unit
  class AccountLimits < APIResource
    path '/accounts'

    attribute :ach_debit_daily_limit, Types::Limit, readonly: true
    attribute :ach_debit_monthly_limit, Types::Limit, readonly: true

    attribute :ach_credit_daily_limit, Types::Limit, readonly: true
    attribute :ach_credit_monthly_limit, Types::Limit, readonly: true

    attribute :card_daily_withdrawal_limit, Types::Limit, readonly: true
    attribute :card_daily_deposit_limit, Types::Limit, readonly: true
    attribute :card_daily_purchase_limit, Types::Limit, readonly: true
    attribute :card_daily_transaction_limit, Types::Limit, readonly: true

    attribute :check_deposits_daily_limit, Types::Limit, readonly: true
    attribute :check_deposits_monthly_limit, Types::Limit, readonly: true

    def self.resource_path(id)
      "#{super(id)}/limits"
    end

    # rubocop:disable Metrics/AbcSize
    def update_resource_from_json_api(data)
      extract_base_resource_details(data)

      clear_attributes!

      extract_ach_debit_limits(data[:attributes][:ach])
      extract_ach_credit_limits(data[:attributes][:ach])
      extract_card_atm_limits(data[:attributes][:card])
      extract_card_transaction_limits(data[:attributes][:card])
      extract_check_deposit_limits(data[:attributes][:check_deposit])

      mark_as_clean!
    end
    # rubocop:enable Metrics/AbcSize

    def extract_base_resource_details(data)
      self.id = data[:id]
      self.type = data[:type]
      self.raw_data = data
      self.relationships = data[:relationships]
    end

    def extract_ach_debit_limits(ach_data)
      self.ach_debit_daily_limit = Types::Limit.new(
        total: ach_data[:limits][:daily_debit],
        used: ach_data[:totals_daily][:debit]
      )

      self.ach_debit_monthly_limit = Types::Limit.new(
        total: ach_data[:limits][:monthly_debit],
        used: ach_data[:totals_monthly][:debit]
      )
    end

    def extract_ach_credit_limits(ach_data)
      self.ach_credit_daily_limit = Types::Limit.new(
        total: ach_data[:limits][:daily_credit],
        used: ach_data[:totals_daily][:credit]
      )

      self.ach_credit_monthly_limit = Types::Limit.new(
        total: ach_data[:limits][:monthly_credit],
        used: ach_data[:totals_monthly][:credit]
      )
    end

    def extract_card_atm_limits(card_data)
      self.card_daily_withdrawal_limit = Types::Limit.new(
        total: card_data[:limits][:daily_withdrawal],
        used: card_data[:totals_daily][:withdrawal]
      )

      self.card_daily_deposit_limit = Types::Limit.new(
        total: card_data[:limits][:daily_deposit],
        used: card_data[:totals_daily][:deposits]
      )
    end

    def extract_card_transaction_limits(card_data)
      self.card_daily_purchase_limit = Types::Limit.new(
        total: card_data[:limits][:daily_purchase],
        used: card_data[:totals_daily][:purchases]
      )

      self.card_daily_transaction_limit = Types::Limit.new(
        total: card_data[:limits][:daily_card_transaction],
        used: card_data[:totals_daily][:card_transactions]
      )
    end

    def extract_check_deposit_limits(check_deposit_data)
      self.check_deposits_daily_limit = Types::Limit.new(
        total: check_deposit_data[:limits][:daily],
        used: check_deposit_data[:totals_daily]
      )

      self.check_deposits_monthly_limit = Types::Limit.new(
        total: check_deposit_data[:limits][:monthly],
        used: check_deposit_data[:totals_monthly]
      )
    end

    include ResourceOperations::Find
  end
end
