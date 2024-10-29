module Unit
  class AchPayment < APIResource
    path '/payments'

    attribute :amount, Types::Integer
    attribute :direction, Types::String
    attribute :counterparty, Types::Counterparty # For inline Counterparties
    attribute :description, Types::String
    attribute :addenda, Types::String
    attribute :idempotency_key, Types::String, factory: -> { SecureRandom.uuid } # Optional
    attribute :tags, Types::Hash # Optional
    attribute :verify_counterparty_balance, Types::Hash # Optional
    attribute :plaid_processor_token, Types::String # Optional

    attribute :status, Types::String, readonly: true
    attribute :reason, Types::String, readonly: true
    attribute :expected_completion_date, Types::DateTime, readonly: true
    attribute :settlement_date, Types::DateTime, readonly: true
    attribute :created_at, Types::DateTime, readonly: true

    belongs_to :account, class_name: 'Unit::DepositAccount'
    belongs_to :customer, class_name: 'Unit::IndividualCustomer'

    # TODO: For linked counterparties
    # belongs_to :application, class_name: 'Unit::Counterparty'

    include ResourceOperations::Find
    include ResourceOperations::List
    include ResourceOperations::Create
  end
end
