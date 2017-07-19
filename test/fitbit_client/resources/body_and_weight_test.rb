# frozen_string_literal: true

require 'test_helper'

module FitbitClient
  module Resources
    class BodyAndWeightTest < Minitest::Test # :nodoc:
      def test_weight_logs
        VCR.use_cassette('weight_logs') do
          response = client.weight_logs(Date.parse('2017-06-29'))
          refute_nil response['weight']
          assert_empty response['weight']
        end

        VCR.use_cassette('weigh_logs_period_7d') do
          response = client.weight_logs(Date.parse('2017-07-19'), '7d')
          assert_equal 2, response['weight'].length
          assert_equal 141, response['weight'][0]['weight']
          assert_equal 10, response['weight'][0]['fat']
          assert_equal 143.3, response['weight'][1]['weight']
          assert_equal 20, response['weight'][1]['fat']
        end
      end

      def test_weight_logs_invalid_token
        VCR.use_cassette('weight_logs_invalid_token') do
          assert_raises { client.weight_logs(Date.parse('2017-06-29')) }
        end
      end

      def test_log_weight
        VCR.use_cassette('log_weight') do
          response = client.log_weight(60.44, Date.parse('2017-07-06'))
          refute_empty response['weightLog']
        end
      end

      def test_delete_weight_log
        VCR.use_cassette('delete_weight_log') do
          assert client.delete_weight_log(1_499_385_599_000)
        end
      end

      def test_body_goals
        VCR.use_cassette('body_goals') do
          response = client.body_goals('weight')
          refute_empty response['goal']
        end
      end

      def test_update_body_fat_goal
        VCR.use_cassette('update_body_fat_goal') do
          response = client.update_body_fat_goal(23.5)
          assert_equal 23.5, response['goal']['fat']
        end
      end

      def test_update_body_weight_goal
        VCR.use_cassette('update_body_weight_goal') do
          response = client.update_body_weight_goal(Date.parse('2017-07-06'), 75, 66)
          refute_empty response['goal']
        end
      end

      def test_body_fat_logs
        VCR.use_cassette('body_fat_logs') do
          response = client.body_fat_logs(Date.parse('2017-07-04'))
          assert_empty response['fat']
        end

        VCR.use_cassette('body_fat_logs_period_7d') do
          response = client.body_fat_logs(Date.parse('2017-07-19'), '7d')
          assert_equal 2, response['fat'].length
          assert_equal 10, response['fat'][0]['fat']
          assert_equal 20, response['fat'][1]['fat']
        end
      end

      def test_body_time_series
        VCR.use_cassette('body_time_series') do
          response = client.body_time_series('bmi', Date.parse('2017-07-06'), '7d')
          assert_equal 7, response['body-bmi'].length
        end
      end

      def test_log_body_fat
        VCR.use_cassette('log_body_fat') do
          response = client.log_body_fat(24.5, Date.parse('2017-07-06'))
          assert_equal 24.5, response['fatLog']['fat']
        end
      end

      def test_delete_body_fat_log
        VCR.use_cassette('delete_body_fat_log') do
          assert client.delete_body_fat_log(1_499_385_599_000)
        end
      end
    end
  end
end
