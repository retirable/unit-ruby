module Unit
  class ReceivedPayment < APIResource
    path '/received-payments'

    attribute :created_at, Types::DateTime, readonly: true
    attribute :status, Types::String, readonly: true
    attribute :wasAdvanced, Types::Boolean, readonly: true
    attribute :amount, Types::Integer, readonly: true
    attribute :completionDate, Types::Date, readonly: true
    attribute :companyName, Types::String, readonly: true
    attribute :counterpartyRoutingNumber, Types::String, readonly: true
    attribute :description, Types::String, readonly: true
    attribute :traceNumber, Types::String, readonly: true
    attribute :secCode, Types::String, readonly: true
    attribute :returnCutoffTime, Types::DateTime, readonly: true
    attribute :canBeReprocessed, Types::Boolean, readonly: true
    attribute :tags, Types::Hash, readonly: true

    belongs_to :account, class_name: 'Unit::DepositAccount'
    belongs_to :customer, class_name: 'Unit::IndividualCustomer' # Optional
    belongs_to :receivePaymentTransaction, 'Unit::Transaction' # Optional
    belongs_to :paymentAdvanceTransaction, 'Unit::Transaction' # Optional
    belongs_to :repayPaymentAdvanceTransaction, 'Unit::Transaction' # Optional
  end
end
