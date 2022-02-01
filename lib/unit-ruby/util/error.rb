module Unit
  module Util
    class Error < StandardError
      attr_accessor :title, :status, :details, :source, :detail

      def initialize(api_response)
        error = api_response['errors'].first
        @title = error['title']
        @status = error['status']
        @source = error['source']
        @details = error['details'] || error['detail']

        super(@details)
      end

      def to_s
        "Unit::Util::Error: #{status} - #{source['pointer']} - #{title} - #{details}"
      end
    end
  end
end
