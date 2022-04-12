module Unit
  class CustomerToken < APIResource
    path '/customers'

    attribute :scope, Types::String
    attribute :verification_token, Types::String
    attribute :verification_code, Types::String
    attribute :expires_in, Types::Integer

    attribute :token, Types::String, readonly: true

    def self.resources_path(id)
      "#{super(id)}/token"
    end

    include ResourceOperations::Create
  end
end
