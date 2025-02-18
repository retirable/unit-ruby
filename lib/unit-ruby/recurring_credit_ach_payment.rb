module Unit
  class RecurringCreditAchPayment < APIResource
    path '/recurring-payments'

    attribute :idempotency_key, Types::String # Optional
    attribute :tags, Types::Hash # Optional

    attribute :amount, Types::Integer # Amount to transfer in cents.
    attribute :description, Types::String # Description of the transfer. Max of 10 characters.
    attribute :addenda, Types::String # Optional. Additional payment description. Max of 80 characters.
    attribute :schedule, Types::Schedule # Schedule for the transfer.

    attribute :status, Types::String, readonly: true
    attribute :number_of_payments, Types::Integer, readonly: true
    attribute :created_at, Types::DateTime, readonly: true

    belongs_to :account, class_name: 'Unit::DepositAccount'
    belongs_to :counterparty, class_name: 'Unit::AchCounterparty'
    belongs_to :customer, class_name: 'Unit::IndividualCustomer'

    def disable
      updated_resource = self.class.connection.post(
        "#{self.class.resource_path(id)}/disable"
      )
      update_resource_from_json_api(updated_resource)
    end

    def enable
      updated_resource = self.class.connection.post(
        "#{self.class.resource_path(id)}/enable"
      )
      update_resource_from_json_api(updated_resource)
    end

    include ResourceOperations::List
    include ResourceOperations::Create
    include ResourceOperations::Find
    include ResourceOperations::Destroy
  end
end
