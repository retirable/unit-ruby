module Unit
  module Util
    class Connection
      class << self
        attr_accessor :api_key, :base_url
      end

      attr_reader :connection

      def initialize
        @connection = Faraday.new(self.class.base_url) do |f|
          f.headers['Authorization'] = "Bearer #{self.class.api_key}"
          f.request :json # encode req bodies as JSON
          f.request :retry # retry transient failures
          f.response :follow_redirects # follow redirects
          f.response :json # decode response bodies as JSON
        end
      end

      # Executes a GET request to the API
      #
      # @return the resource (or array of resources) returned from the API
      def get(path, params = nil)
        response = connection.get(path, params)

        handle_errors(response)

        from_json_api(response.body)
      end

      # Executes a POST request to the API
      #
      # @return [Unit::APIResource] a new instance of the resource
      def post(path, data = nil)
        response = connection.post do |req|
          req.url path
          req.headers['Content-Type'] = 'application/vnd.api+json'
          req.body = data.deep_transform_keys! { |key| key.to_s.camelize(:lower) } if data
        end

        handle_errors(response)

        from_json_api(response.body)
      end

      # Executes a PATCH request to the API
      def patch(path, data = nil)
        response = connection.patch do |req|
          req.url path
          req.headers['Content-Type'] = 'application/vnd.api+json'
          req.body = data.deep_transform_keys! { |key| key.to_s.camelize(:lower) } if data
        end

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
end
