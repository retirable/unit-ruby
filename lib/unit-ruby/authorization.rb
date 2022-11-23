module Unit
  class Authorization < APIResource
    path '/authorizations'

    attribute :created_at, Types::DateTime, readonly: true
    attribute :amount, Types::Integer, readonly: true
    attribute :card_last4_digits, Types::String, readonly: true
    attribute :status, Types::String, readonly: true
    attribute :decline_reason, Types::String, readonly: true # Optional
    attribute :merchant, Types::Hash, readonly: true
    attribute :recurring, Types::Boolean, readonly: true
    attribute :payment_method, Types::String, readonly: true # Optional
    attribute :digital_wallet, Types::String, readonly: true # Optional
    attribute :card_verification_data, Types::Hash, readonly: true # Optional
    attribute :card_network, Types::String, readonly: true # Optional
    attribute :tags, Types::Hash, readonly: true # Optional
    attribute :cash_withdrawal_amount, Types::Integer, readonly: true # Optional

    include ResourceOperations::List
    include ResourceOperations::Find
  end
end
