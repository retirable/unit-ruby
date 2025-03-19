module Unit
  class WirePayment < APIResource
    path '/payments'

    attribute :amount, Types::Integer
    attribute :description, Types::String
    attribute :counterparty, Types::WireCounterparty
    attribute :idempotency_key, Types::String, factory: -> { SecureRandom.uuid } # Optional
    attribute :tags, Types::Hash # Optional

    belongs_to :account, class_name: 'Unit::DepositAccount'

    attribute :status, Types::String, readonly: true

    include ResourceOperations::Find
    include ResourceOperations::List
    include ResourceOperations::Create
  end
end
