module Unit
  class IndividualVirtualDebitCard < APIResource
    path '/cards'

    attribute :idempotency_key, Types::String # Optional
    attribute :tags, Types::Hash # Optional
    attribute :limits, Types::Hash # Optional

    attribute :created_at, Types::DateTime, readonly: true
    attribute :last4_digits, Types::String, readonly: true
    attribute :expiration_date, Types::String, readonly: true
    attribute :status, Types::String, readonly: true

    belongs_to :customer, class_name: 'Unit::IndividualCustomer'
    belongs_to :account, class_name: 'Unit::DepositAccount'

    include ResourceOperations::List
    include ResourceOperations::Create
    include ResourceOperations::Save
    include ResourceOperations::Find
  end
end
