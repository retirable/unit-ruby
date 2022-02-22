module Unit
  class PinStatus < APIResource
    path '/cards'

    attribute :status, Types::String

    def self.resource_path(id)
      "#{super(id)}/secure-data/pin/status"
    end

    include ResourceOperations::Find
  end
end
