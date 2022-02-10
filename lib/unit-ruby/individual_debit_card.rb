module Unit
  class IndividualDebitCard < APIResource
    path '/cards'

    attribute :shipping_address, Types::Address # Optional. Address to ship the card to. If not specified, the individual address is used.
    attribute :design, Types::String # Optional. You may omit if you only have one card design. Please contact Unit if you need multiple card designs.
    attribute :additional_embossed_text, Types::String # Optional, up to 21 characters. Use for a second cardholder name, company name, or other data to be embossed on a card.
    attribute :idempotency_key, Types::String # Optional
    attribute :tags, Types::Hash # Optional
    attribute :limits, Types::Hash # Optional

    attribute :created_at, Types::DateTime, readonly: true
    attribute :last4_digits, Types::String
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
