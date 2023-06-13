module Unit
  class IndividualApplication < APIResource
    path '/applications'

    attribute :ssn, Types::String #	SSN (or ITIN) of the individual (numbers only). Either an SSN or a passport number is required.
    attribute :passport, Types::String # Passport number of the individual. Either an SSN or a passport number is required.
    attribute :nationality, Types::String # Required on if a passport is used as the main ID. Two letters representing the individual nationality. (e.g. "US").
    attribute :full_name, Types::FullName # Full name of the individual.
    attribute :date_of_birth, Types::Date # RFC3339 Date only (e.g. "2001-08-15").
    attribute :address, Types::Address # Address of the individual.
    attribute :phone, Types::Phone # Phone number of the individual.
    attribute :email, Types::String # Email address of the individual.
    attribute :ip, Types::String # Optional. IP address of the end-customer creating the application. Both IPv4 and IPv6 formats are supported. Highly recommended as a fraud prevention measure, if the information is available when submitting the application.
    attribute :sole_proprietorship, Types::Boolean # Optional. Default: false. Indicates whether the individual is a sole proprietor.
    attribute :ein, Types::String # Optional. If the individual is a sole proprietor who has an Employer Identification Number, specify it here. Not all sole proprietors have an EIN, so this attribute is optional, even when soleProprietorship is set to true.
    attribute :dba, Types::String # Optional. If the individual is a sole proprietor who is doing business under a different name, specify it here. This attribute is optional, even when soleProprietorship is set to true.
    attribute :tags, Types::Hash # Optional. Tags that will be copied to the customer that this application creates
    attribute :idempotency_key, Types::String, factory: -> { SecureRandom.uuid } # Optional
    attribute :device_fingerprints, Types::Array # array of Device Fingerprint	Optional. A list of device fingerprints for fraud and risk prevention
    attribute :occupation, Types::String # Occupation of the individual, from a list of possible values.

    attribute :created_at, Types::DateTime, readonly: true
    attribute :status, Types::String, readonly: true
    attribute :message, Types::String, readonly: true
    attribute :evaluation_id, Types::String, readonly: true
    attribute :authorized_users, Types::Array, readonly: true

    belongs_to :customer, class_name: 'Unit::IndividualCustomer'

    include ResourceOperations::Find
    include ResourceOperations::List
    include ResourceOperations::Create
  end
end
