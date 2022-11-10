module Unit
  class BatchRelease < APIResource
    path '/batch-releases'

    attribute :amount, Types::Integer
    attribute :description, Types::String
    attribute :sender_name, Types::String
    attribute :sender_address, Types::Address
    attribute :sender_account_number, Types::String
    attribute :tags, Types::Hash # Optional
    attribute :idempotency_key, Types::String # Optional

    belongs_to :batch_account, resource_type: "batchAccount", class_name: 'Unit::DepositAccount'
    belongs_to :receiver, resource_type: "depositAccount", class_name: 'Unit::DepositAccount'

    include ResourceOperations::BulkCreate
  end
end
