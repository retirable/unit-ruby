module Unit
  class TaxForm < APIResource
    path '/tax-forms'

    attribute :tax_year, Types::String, readonly: true
    attribute :form_type, Types::String, readonly: true

    belongs_to :customer, class_name: 'Unit::IndividualCustomer'
    has_many :accounts, class_name: 'Unit::DepositAccount'

    def pdf
      self.class.connection.get(
        "tax-forms/#{id}/pdf",
        raw: true
      )
    end

    include ResourceOperations::List
    include ResourceOperations::Find
  end
end
