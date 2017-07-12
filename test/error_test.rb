require 'test_helper'

module FitbitClient
  class ErrorTest < Minitest::Test
    def error
      @error ||= FitbitClient::Error.new('sample message')
    end

    def error_with_response
      @error_with_response ||= FitbitClient::Error.new('sample message', response)
    end

    def response
      env = OpenStruct.new
      env.url = 'https://localhost/sample.json'

      inner_response = OpenStruct.new
      inner_response.env = env

      response = OpenStruct.new
      response.status = 200
      response.body = '{}'
      response.response = inner_response
      response
    end

    def test_json_response
      assert_nil error.json_response
    end

    def test_message
      assert_equal 'sample message', error.message
      assert_equal "sample message, HTTP_STATUS: 200, HTTP_BODY: {}, HTTP_URL: https://localhost/sample.json", error_with_response.message
    end
  end
end

