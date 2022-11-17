module Unit
  class PurchaseAuthorizationRequest < APIResource
    path '/authorization-requests'

    attribute :created_at, Types::DateTime, readonly: true
    attribute :amount, Types::Integer, readonly: true
    attribute :status, Types::String, readonly: true
    attribute :partial_approval_allowed, Types::Boolean, readonly: true
    attribute :approved_amount, Types::Integer, readonly: true # Optional
    attribute :decline_reason, Types::String, readonly: true # Optional
    attribute :merchant, Types::Hash, readonly: true
    attribute :recurring, Types::Boolean, readonly: true
    attribute :ecommerce, Types::Boolean, readonly: true # Optional
    attribute :card_present, Types::Boolean, readonly: true # Optional
    attribute :payment_method, Types::String, readonly: true # Optional
    attribute :digital_wallet, Types::String, readonly: true # Optional
    attribute :card_verification_data, Types::Hash, readonly: true # Optional
    attribute :card_network, Types::String, readonly: true # Optional
    attribute :healthcare_amounts, Types::Hash, readonly: true # Optional
    attribute :tags, Types::Hash, readonly: true # Optional
    attribute :cash_withdrawal_amount, Types::Integer, readonly: true # Optional


    belongs_to :customer, class_name: 'Unit::IndividualCustomer'
    belongs_to :account, class_name: 'Unit::DepositAccount'
    belongs_to :card, class_name: 'Unit::IndividualDebitCard' # It may actually be a virtual card, but the returned data will still be correct
    belongs_to :funding_account, class_name: 'Unit::DepositAccount'

    include ResourceOperations::Find
  end
end
