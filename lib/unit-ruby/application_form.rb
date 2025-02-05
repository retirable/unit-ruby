module Unit
  class ApplicationForm < APIResource
    path '/application-forms'

    attribute :idempotency_key, Types::String # required for V2024_06 requests
    attribute :tags, Types::Hash # Optional
    attribute :allowed_application_types, Types::Array # Optional. Array of Individual, Business or SoleProprietorship.
    attribute :applicant_details, Types::ApplicationFormPrefill # Optional. Add data that is already known about the end-customer to be auto populated on the form.
    attribute :settings_override, Types::ApplicationFormSettingsOverride # Optional. Override disclosure URLs that were defined in the application form settings.

    attribute :stage, Types::String, readonly: true
    attribute :url, Types::String, readonly: true

    belongs_to :application, class_name: 'Unit::IndividualApplication'

    include ResourceOperations::Create
    include ResourceOperations::Find
  end
end
