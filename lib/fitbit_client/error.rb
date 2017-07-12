# frozen_string_literal: true

module FitbitClient
  class Error < StandardError
    attr_accessor :response

    def initialize(message, response = nil)
      @message = message
      @response = response
    end

    def json_response
      @json_response ||= JSON.parse(response.body) if response
    end

    def to_s
      if response
        "#{@message}, HTTP_STATUS: #{response.status}, HTTP_BODY: #{response.body}, HTTP_URL: #{response.response.env.url}"
      else
        @message.to_s
      end
    end
  end
end
