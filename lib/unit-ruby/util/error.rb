module Unit
  class Error < StandardError
    attr_accessor :message, :status, :details, :detail

    def initialize(api_response)
      error = api_response['errors'].first
      @message = error['title']
      @status = error['status']
      @details = error['details'] || error['detail']

      super(@details)
    end
  end
end
