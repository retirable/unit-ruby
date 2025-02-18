require 'faraday'
require 'faraday/retry'
require 'active_support/core_ext/hash'

module Unit
  class Connection
    class << self
      attr_accessor :api_key, :base_url, :trust_token
    end

    attr_reader :connection

    def initialize(custom_headers = {})
      @connection = Faraday.new(self.class.base_url) do |f|
        f.headers['UNIT_TRUST_TOKEN'] = self.class.trust_token if self.class.trust_token
        f.headers['Authorization'] = "Bearer #{self.class.api_key}"
        f.headers['Content-Type'] = 'application/vnd.api+json'
        f.headers.merge!(custom_headers)
        f.request :json # encode req bodies as JSON
        f.request :retry # retry transient failures
        f.response :json # decode response bodies as JSON
      end
    end

    # Executes a GET request to the API
    #
    # @return the resource (or array of resources) returned from the API
    def get(path, params = nil, raw: false)
      response = connection.get(path, params)

      handle_errors(response)

      raw ? response.body : from_json_api(response.body)
    end

    # Executes a POST request to the API
    #
    # @return [Unit::APIResource] a new instance of the resource
    def post(path, data = nil)
      response = connection.post do |req|
        req.url path
        req.body = data.deep_transform_keys! { |key| key.to_s.camelize(:lower) } if data
      end

      handle_errors(response)

      from_json_api(response.body)
    end

    # Executes a DELETE request to the API
    #
    # @return boolean
    def delete(path)
      response = connection.delete(path)

      handle_errors(response)

      true
    end

    # Executes a PATCH request to the API
    def patch(path, data = nil)
      response = connection.patch do |req|
        req.url path
        req.body = data.deep_transform_keys! { |key| key.to_s.camelize(:lower) } if data
      end

      handle_errors(response)

      from_json_api(response.body)
    end

    # Executes a PUT of a JSON object
    def put(path, data = nil)
      response = connection.put(path, data)

      handle_errors(response)

      from_json_api(response.body)
    end

    def from_json_api(response_body)
      response_body.deep_transform_keys do |key|
        key.to_s.underscore.to_sym
      end.fetch(:data)
    end

    def handle_errors(response)
      return if response.success?

      raise(Error, response.body)
    end
  end
end
