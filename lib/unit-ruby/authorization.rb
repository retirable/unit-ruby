module Unit
  class Authorization < APIResource
    path '/authorizations'

    attribute :amount, Types::Integer
    attribute :status, Types::String
    attribute :summary, Types::String
    attribute :created_at, Types::DateTime, readonly: true

    include ResourceOperations::List
  end
end
