# frozen_string_literal: true

require 'test_helper'

module FitbitClient
  module Resources
    class RequestTest < Minitest::Test # :nodoc:
      def test_invalid_token
        VCR.use_cassette('network/invalid_token') do
          assert_raises(FitbitClient::TokenError) { client.lifetime_stats }
        end
      end

      def test_invalid_refresh_token
        VCR.use_cassette('network/invalid_refresh_token') do
          assert_raises(FitbitClient::TokenError) { client.lifetime_stats }
        end
      end

      def test_successful_post?
        response = OpenStruct.new
        response.status = 201
        response.body = '{}'
        assert client.successful_post?(response)

        response.status = 204
        refute client.successful_post?(response)

        response.status = 201
        response.body = '{something}'
        refute client.successful_post?(response)
      end

      def test_successful_delete?
        response = OpenStruct.new
        response.status = 204
        response.body = ''
        assert client.successful_delete?(response)

        response.status = 201
        refute client.successful_delete?(response)

        response.status = 204
        response.body = '{something}'
        refute client.successful_delete?(response)
      end
    end
  end
end
