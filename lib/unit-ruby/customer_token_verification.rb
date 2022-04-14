module Unit
  class CustomerTokenVerification < APIResource
    path '/customers'

    attribute :channel, Types::String
    attribute :verification_token, Types::String, readonly: true

    def self.resources_path(id)
      "#{super(id)}/token/verification"
    end

    include ResourceOperations::Create
  end
end
