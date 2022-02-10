module Unit
  class Transaction < Util::APIResource
    path '/transactions'

    attribute :direction, Types::String
    attribute :amount, Types::Integer
    attribute :balance, Types::Integer
    attribute :summary, Types::String
    attribute :created_at, Types::DateTime, readonly: true

    include Util::ResourceOperations::List
  end
end
