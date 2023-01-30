module Unit
  class Transaction < APIResource
    path '/transactions'

    attribute :direction, Types::String
    attribute :amount, Types::Integer
    attribute :balance, Types::Integer
    attribute :summary, Types::String
    attribute :created_at, Types::DateTime, readonly: true

    def amount_in_cents
      amount
    end

    def amount_in_dollars
      amount / 100
    end

    def balance_in_cents
      balance
    end

    def balance_in_dollars
      balance / 100
    end

    include ResourceOperations::List
  end
end
