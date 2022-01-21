module Unit
  class Institution < Util::APIResource
    attribute :routing_number, Types::String # Routing number of the institution. Valid 9-digit ABA routing transit number.
    attribute :name, Types::String # Name of the institution.
    attribute :address, Types::String # Optional. Address of the institution.
    attribute :is_ach_supported, Types::Boolean # Is FedACH participant.
    attribute :is_wire_supported, Types::Boolean # Is Fedwire participant.

    path '/institutions'

    include Util::ResourceOperations::Find

    def self.find_by(routing_number:)
      find(routing_number)
    end

    # Unit::Institution.find_by_routing_number('021000021')
  end
end
