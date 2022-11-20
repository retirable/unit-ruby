require 'unit-ruby/purchase_authorization_request'

module Unit
  class ApproveAuthorizationRequest < APIResource
    path '/authorization-requests'
    response_resource PurchaseAuthorizationRequest

    attribute :amount, Types::Integer # Optional
    attribute :funding_account, Types::String # Optional
    attribute :tags, Types::Hash # Optional

    def self.resources_path(id)
      "#{super(id)}/approve"
    end

    include ResourceOperations::Create
  end
end
