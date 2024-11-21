module Unit
  class ReceivedPayment < APIResource
    path '/received-payments'

    attribute :status, Types::String, readonly: true
    attribute :direction, Types::String, readonly: true
    attribute :was_advanced, Types::Boolean, readonly: true
    attribute :is_advanceable, Types::Boolean, readonly: true
    attribute :amount, Types::Integer, readonly: true
    attribute :return_reason, Types::String, readonly: true
    attribute :ach_return_reason, Types::String, readonly: true
    attribute :completion_date, Types::DateTime, readonly: true
    attribute :company_name, Types::String, readonly: true
    attribute :counterparty_routing_number, Types::String, readonly: true
    attribute :description, Types::String, readonly: true
    attribute :addenda, Types::String, readonly: true
    attribute :trace_number, Types::String, readonly: true
    attribute :sec_code, Types::String, readonly: true
    attribute :receiving_entity_name, Types::String, readonly: true
    attribute :tags, Types::Hash # Optional

    attribute :created_at, Types::DateTime, readonly: true

    belongs_to :account, class_name: 'Unit::DepositAccount'
    belongs_to :customer, class_name: 'Unit::IndividualCustomer'

    include ResourceOperations::Find
    include ResourceOperations::List
  end
end
