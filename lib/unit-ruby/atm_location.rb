module Unit
  class AtmLocation < APIResource
    path '/atm-locations'
    attribute :network, Types::String
    attribute :address, Types::Address
    attribute :coordinates, Types::Coordinates
    attribute :distance, Types::Float
    attribute :location_name, Types::String
    attribute :accept_deposits, Types::Boolean
    attribute :surcharge_free, Types::Boolean

    include ResourceOperations::List

    def self.list_by_coordinates(latitude:, longitude:, search_radius:)
      list(
        where: {
          coordinates: { longitude: longitude, latitude: latitude }.to_json,
          searchRadius: search_radius
        }
      )
    end

    def self.list_by_postal_code(postal_code:, search_radius:)
      list(
        where: {
          postal_code: postal_code,
          searchRadius: search_radius
        }
      )
    end

    def self.list_by_address(address:, search_radius:)
      list(
        where: {
          postal_code: address,
          searchRadius: search_radius
        }
      )
    end
  end
end
