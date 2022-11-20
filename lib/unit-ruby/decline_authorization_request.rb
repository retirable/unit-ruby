require 'unit-ruby/purchase_authorization_request'

module Unit
  class DeclineAuthorizationRequest < APIResource
    path '/authorization-requests'
    response_resource PurchaseAuthorizationRequest

    attribute :reason, Types::String

    def self.resources_path(id)
      "#{super(id)}/decline"
    end

    include ResourceOperations::Create
  end
end
