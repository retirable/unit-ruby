module Unit
  class ApplicationForm < APIResource
    path '/application-forms'
    header 'X-Accept-Version' => 'V2024_06'

    attribute :tags, Types::Hash # Optional
    attribute :allowed_application_types, Types::Array # Optional. Array of Individual, Business or SoleProprietorship.
    attribute :applicant_details, Types::ApplicationFormPrefill # Optional. Add data that is already known about the end-customer to be auto populated on the form.
    attribute :settings_override, Types::ApplicationFormSettingsOverride # Optional. Override disclosure URLs that were defined in the application form settings.
    attribute :idempotency_key, Types::String

    belongs_to :application, class_name: 'Unit::IndividualApplication'

    def url
      links[:related][:href]
    end

    include ResourceOperations::Create
    include ResourceOperations::Find
    include ResourceOperations::List
  end
end
