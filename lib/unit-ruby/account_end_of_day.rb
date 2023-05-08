module Unit
  class AccountEndOfDay < APIResource
    path '/account-end-of-day'

    attribute :date, Types::DateTime, readonly: true
    attribute :balance, Types::Integer, readonly: true
    attribute :hold, Types::Integer, readonly: true
    attribute :available, Types::Integer, readonly: true

    belongs_to :account, class_name: 'Unit::DepositAccount'
    belongs_to :customer, class_name: 'Unit::IndividualCustomer'

    include ResourceOperations::List
  end
end
