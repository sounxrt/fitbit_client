# frozen_string_literal: true

module FitbitClient
  module Resources
    # The Fitbit's Subscriptions API allows third-party applications
    # to be notified when Fitbit user data changes.
    #
    # This allows apps to have a user's latest data without having to implement
    # a polling or scheduling system to retrieve user's data.
    module Subscription
      # You must add a subscription in your application so that users will
      # get notifications and return a response in the format requested.
      #
      # The <em>activity_type</em> must be one of activities, body, foods, sleep
      # if nil value is passed the activity, nutrition, profile, settings,
      # sleep, weight scopes are required.
      #
      # The <em>subscription_id</em> value provides a way to associate an update
      # with a particular user stream in your application, you must generate
      # this value.
      def add_subscription(activity_type, subscription_id)
        post_json(path_user_version("#{subscription_path(activity_type)}/#{subscription_id}"))
      end

      # Deletes a subscription for a user.
      # A successful request will return a 204 status code and empty response body.
      #
      # returns true when succesfully deleted
      def delete_subscription(activity_type, subscription_id)
        path = path_user_version("#{subscription_path(activity_type)}/#{subscription_id}")
        successful_request?(delete(path))
      end

      # Get a list of a user's subscriptions for your application in the format
      # requested.
      #
      # You can either fetch subscriptions for a specific collection or the
      # entire list of subscriptions for the user.
      #
      # For best practice, make sure that your application maintains this
      # list on your side and use this endpoint only to periodically ensure
      # data consistency.
      def list_of_subscriptions(activity_type)
        get_json(path_user_version(subscription_path(activity_type)))
      end

      private

      def subscription_path(activity_type)
        activity_type ? "/#{subscription_type_whitelist(activity_type)}/apiSubscriptions" : '/apiSubscriptions'
      end

      def subscription_type_whitelist(activity_type)
        if FitbitClient::VALID_SUBSCRIPTIONS.include?(activity_type.to_sym)
          activity_type
        else
          raise "Invalid activity type requested for subscription, must be one of #{FitbitClient::VALID_SUBSCRIPTIONS}"
        end
      end
    end
  end
end
