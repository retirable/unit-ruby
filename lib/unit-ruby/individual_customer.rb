module Unit
  class IndividualCustomer < APIResource
    path '/customers'

    attribute :ssn, Types::String #	SSN (or ITIN) of the individual (numbers only). Either an SSN or a passport number is required.
    attribute :passport, Types::String # Passport number of the individual. Either an SSN or a passport number is required.
    attribute :nationality, Types::String # Required on if a passport is used as the main ID. Two letters representing the individual nationality. (e.g. "US").
    attribute :full_name, Types::FullName # Full name of the individual.
    attribute :date_of_birth, Types::Date # RFC3339 Date only (e.g. "2001-08-15").
    attribute :address, Types::Address # Address of the individual.
    attribute :phone, Types::Phone # Phone number of the individual.
    attribute :email, Types::String # Email address of the individual
    attribute :dba, Types::String # Optional. If the individual is a sole proprietor who is doing business under a different name.
    attribute :sole_proprietorship, Types::Boolean
    attribute :tags, Types::Hash # Optional. Tags that will be copied to the customer that this application creates
    attribute :idempotency_key, Types::String # Optional
    attribute :risk_rate, Types::String, readonly: true
    attribute :authorized_users, Types::Array, readonly: true
    attribute :created_at, Types::DateTime, readonly: true
    attribute :status, Types::String, readonly: true # Status of the customer, either Active or Archived.
    attribute :archive_reason, Types::String, readonly: true # Optional. The reason the customer was archived.

    belongs_to :application, class_name: 'Unit::IndividualApplication'

    # Archives the customer. This action cannot be undone.
    # All accounts of the customer must be closed first.
    #
    # @param reason [String] Inactive, FraudACHActivity, FraudCardActivity, FraudCheckActivity,
    #   FraudApplicationHistory, FraudAccountActivity, FraudClientIdentified,
    #   FraudLinkedToFraudulentCustomer or ByBank
    def archive(reason:)
      archived_customer = self.class.connection.post(
        "#{self.class.resource_path(id)}/archive",
        {
          data: {
            type: 'archiveCustomer',
            attributes: { reason: reason }
          }
        }
      )

      update_resource_from_json_api(archived_customer)
    end

    include ResourceOperations::List
    include ResourceOperations::Create
    include ResourceOperations::Save
    include ResourceOperations::Find
  end
end
