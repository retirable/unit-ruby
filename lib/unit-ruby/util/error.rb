module Unit
  class Error < StandardError
    attr_accessor :title, :status, :details, :detail

    def initialize(api_response)
      error = api_response['errors'].first
      @title = error['title']
      @status = error['status']
      @details = error['details'] || error['detail']

      super("#{@title} #{@status}: #{@details}")
    end
  end
end
