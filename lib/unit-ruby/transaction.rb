module Unit
  class Transaction < APIResource
    path '/transactions'

    attribute :direction, Types::String
    attribute :amount, Types::Integer
    attribute :balance, Types::Integer
    attribute :summary, Types::String
    attribute :created_at, Types::DateTime, readonly: true

    include ResourceOperations::List
  end
end
