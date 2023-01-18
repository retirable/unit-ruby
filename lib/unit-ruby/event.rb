module Unit
  class Event < APIResource
    path '/events'

    attribute :created_at, Types::DateTime, readonly: true

    include ResourceOperations::List
    include ResourceOperations::Find

    def raw_attributes
      raw_data.fetch(:attributes)
    end
  end
end
