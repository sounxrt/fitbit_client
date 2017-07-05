# frozen_string_literal: true
require 'test_helper'

module FitbitClient
  module Resources
    class BodyAndWeightTest < Minitest::Test
      def client
        @client ||= FitbitClient::Client.new('token', 'refresh_token', client_id: '1234567', client_secret: 'qwertyuiopoiuytr123456')
      end

      def test_weight_logs
        VCR.use_cassette('weight_logs') do
          response = client.weight_logs(Date.today)
          refute_nil response['weight']
          assert_empty response['weight']
        end
      end

      def test_weight_logs_invalid_token
        VCR.use_cassette('weight_logs_invalid_token') do
          assert_raises { client.weight_logs(Date.today) }
        end
      end
    end
  end
end
