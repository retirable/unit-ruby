module Unit
  # A transfer of funds between two Unit accounts
  class BookPayment < APIResource
    path '/payments'

    attribute :amount, Types::Integer # Amount to transfer in cents.
    attribute :description, Types::String # Description of the payment. Max of 50 characters.
    attribute :transaction_summary_override, Types::String # Optional. Overrides the transaction summary. Max of 100 characters.
    attribute :idempotency_key, Types::String # Optional
    attribute :tags, Types::Hash # Optional

    attribute :direction, Types::String, readonly: true
    attribute :summary, Types::String, readonly: true
    attribute :status, Types::String, readonly: true
    attribute :reason, Types::String, readonly: true
    attribute :created_at, Types::DateTime, readonly: true

    belongs_to :account, class_name: 'Unit::DepositAccount'
    belongs_to :counterparty_account, class_name: 'Unit::DepositAccount', type: :depositAccount
    belongs_to :customer, class_name: 'Unit::IndividualCustomer'
    belongs_to :counterparty_customer, class_name: 'Unit::IndividualCustomer'

    include ResourceOperations::Find
    include ResourceOperations::List
    include ResourceOperations::Create
  end
end
