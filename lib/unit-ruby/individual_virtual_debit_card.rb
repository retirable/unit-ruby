module Unit
  class IndividualVirtualDebitCard < APIResource
    path '/cards'

    attribute :idempotency_key, Types::String, factory: -> { SecureRandom.uuid } # Optional
    attribute :tags, Types::Hash # Optional
    attribute :limits, Types::Hash # Optional

    attribute :created_at, Types::DateTime, readonly: true
    attribute :last4_digits, Types::String, readonly: true
    attribute :expiration_date, Types::String, readonly: true
    attribute :status, Types::String, readonly: true

    belongs_to :customer, class_name: 'Unit::IndividualCustomer'
    belongs_to :account, class_name: 'Unit::DepositAccount'

    include ResourceOperations::List
    include ResourceOperations::Create
    include ResourceOperations::Save
    include ResourceOperations::Find

    def resource_path
      self.class.resource_path(id)
    end

    def report_stolen
      updated_resource = self.class.connection.post(
        "#{resource_path}/report-stolen"
      )

      update_resource_from_json_api(updated_resource)
    end

    def report_lost
      updated_resource = self.class.connection.post(
        "#{resource_path}/report-lost"
      )

      update_resource_from_json_api(updated_resource)
    end

    def close
      updated_resource = self.class.connection.post(
        "#{resource_path}/close"
      )

      update_resource_from_json_api(updated_resource)
    end

    def freeze
      updated_resource = self.class.connection.post(
        "#{resource_path}/freeze"
      )

      update_resource_from_json_api(updated_resource)
    end

    def unfreeze
      updated_resource = self.class.connection.post(
        "#{resource_path}/unfreeze"
      )

      update_resource_from_json_api(updated_resource)
    end
  end
end
