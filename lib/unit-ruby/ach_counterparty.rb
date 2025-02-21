module Unit
  class AchCounterparty < APIResource
    path '/counterparties'

    attribute :idempotency_key, Types::String # Optional
    attribute :tags, Types::Hash # Optional

    attribute :name, Types::String # Name of the account holder
    attribute :bank, Types::String # Bank name
    attribute :created_at, Types::DateTime
    attribute :routing_number, Types::String # Routing number of account.
    attribute :account_number, Types::String # Account number, together with the routingNumber forms the identifier of the account on the ACH network.
    attribute :account_type, Types::String # Account type, either Checking, Savings or Loan. Default is Checking.
    attribute :type, Types::String # Type of the counterparty, either Business, Person or Unknown.

    belongs_to :customer, class_name: 'Unit::IndividualCustomer'

    include ResourceOperations::List
    include ResourceOperations::Create
    include ResourceOperations::Save
    include ResourceOperations::Find
  end
end
