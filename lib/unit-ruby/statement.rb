module Unit
  class Statement < APIResource
    path '/statements'

    attribute :period, Types::String

    def self.pdf_for(statement_id:, customer_id:)
      url = base_url(statement_id, :pdf, customer_id)
      statement_connection(url).get.body
    end

    def self.html_for(statement_id:, customer_id:)
      url = base_url(statement_id, :html, customer_id)
      statement_connection(url).get.body
    end

    def self.base_url(statement_id, response_type, customer_id)
      "#{Unit::Connection.base_url}statements/#{statement_id}/#{response_type}" \
        "?filter[customerId]=#{customer_id}"
    end

    def self.statement_connection(url)
      # Establishing a new connection to avoid having to alter the existing connection to support pdf / html responses
      Faraday.new(url) do |f|
        f.headers['Authorization'] = "Bearer #{Unit::Connection.api_key}"
      end
    end

    include ResourceOperations::List
  end
end
