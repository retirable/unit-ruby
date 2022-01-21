module Unit
  class DepositAccount < Util::APIResource
    path '/accounts'

    attribute :deposit_product, Types::String # The name of the deposit product
    attribute :idempotency_key, Types::String # Optional
    attribute :tags, Types::Hash # Optional

    attribute :created_at, Types::DateTime, readonly: true
    attribute :name, Types::String, readonly: true # Name of the account holder
    attribute :routing_number, Types::String, readonly: true # Routing number of account.
    attribute :account_number, Types::String, readonly: true # Account number, together with the routingNumber forms the identifier of the account on the ACH network.
    attribute :currency, Types::String, readonly: true # Currency of the account.
    attribute :balance, Types::Integer, readonly: true # The balance amount (in cents). The balance represents the funds that are are currently in the account (not taking into account future commitments). The balance equals the sum of 'available' and 'hold'.
    attribute :hold, Types::Integer, readonly: true # The hold amount (in cents). The hold represents funds that are not available for spending, typically due to an outstanding card authorization.
    attribute :available, Types::Integer, readonly: true # The available balance for spending (in cents). Equals the balance minus the hold amount.
    attribute :status, Types::String, readonly: true # Status of the account, either Open, Frozen, or Closed.
    attribute :freeze_reason, Types::String, readonly: true # Optional. The reason the account was frozen, either Fraud or free-text description.
    attribute :close_reason, Types::String, readonly: true # Optional. The reason the account was closed, either ByCustomer or Fraud.

    belongs_to :customer, class_name: 'Unit::IndividualCustomer'

    include Util::ResourceOperations::List
    include Util::ResourceOperations::Create
    include Util::ResourceOperations::Save
    include Util::ResourceOperations::Find
  end
end
