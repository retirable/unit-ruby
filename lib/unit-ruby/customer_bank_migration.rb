module Unit
  class CustomerBankMigration < APIResource
    path '/migrations'

    attribute :from_bank, Types::String
    attribute :to_bank, Types::String
    attribute :idempotency_key, Types::String
    attribute :deadline, Types::Date
    attribute :balance_transfer_timing, Types::String # Optional. The timing of the balance transfer. Default is "NewAccountCreation"
    attribute :status, Types::String, readonly: true
    attribute :migration_url, Types::String, readonly: true
    attribute :created_at, Types::DateTime, readonly: true
    attribute :updated_at, Types::DateTime, readonly: true

    belongs_to :customer, class_name: 'Unit::IndividualCustomer'
    belongs_to :white_label_theme, class_name: 'Unit::WhiteLabelTheme'
    belongs_to :outreach_settings, class_name: 'Unit::OutreachSettings'

    include ResourceOperations::Create
    include ResourceOperations::Find
  end
end
