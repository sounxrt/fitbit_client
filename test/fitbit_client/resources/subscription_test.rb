# frozen_string_literal: true

require 'test_helper'

module FitbitClient
  module Resources
    class SubscriptionTest < Minitest::Test # :nodoc:
      def test_add_subscription
        VCR.use_cassette('add_subscription') do
          response = client.add_subscription(:sleep, '114sleep')
          assert_equal 'user', response['ownerType']
          assert_equal 'sleep', response['collectionType']
        end
      end

      def test_list_of_subscriptions
        VCR.use_cassette('list_of_subscriptions') do
          response = client.list_of_subscriptions(:sleep)
          assert_equal 'user', response['apiSubscriptions'][0]['ownerType']
          assert_equal 'sleep', response['apiSubscriptions'][0]['collectionType']
        end
      end

      def test_delete_subscription
        VCR.use_cassette('delete_subscription') do
          assert client.delete_subscription(:sleep, '114sleep')
        end
      end
    end
  end
end

