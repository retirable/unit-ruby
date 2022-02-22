module Unit
  class Statement < APIResource
    path '/statements'

    attribute :period, Types::String

    include ResourceOperations::List
  end
end
