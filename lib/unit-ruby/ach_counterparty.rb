module Unit
  class AchCounterparty < APIResource
    path '/counterparties'

    attribute :name, Types::String
    attribute :plaid_processor_token, Types::String
    attribute :type, Types::String
    attribute :verify_name, Types::Boolean # Optional
    attribute :permissions, Types::String # Optional
    attribute :tags, Types::Hash # Optional
    attribute :idempotency_key, Types::String # Optional

    attribute :bank, Types::String, readonly: true
    attribute :routing_number, Types::String, readonly: true
    attribute :account_number, Types::String, readonly: true
    attribute :account_type, Types::String, readonly: true

    belongs_to :customer, class_name: 'Unit::IndividualCustomer'

    include ResourceOperations::Find
    include ResourceOperations::List
    include ResourceOperations::Create
  end
end
