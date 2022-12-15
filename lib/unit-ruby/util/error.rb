module Unit
  class Error < StandardError
    attr_accessor :title, :status, :details, :detail, :api_response

    def initialize(api_response)
      @api_response = api_response

      error = api_response.body['errors']&.first

      if error
        @title = error['title']
        @status = error['status'] || api_response.status
        @details = error['details'] || error['detail']

        message = "[HTTP #{api_response.status}] #{title}\n"
        message << "Details: #{details}"
      else
        @status = status

        message = "[HTTP #{api_response.status}] Unexpected API error\n"
        message << "Response body: #{api_response.body}"
      end

      super(message)
    end
  end
end
