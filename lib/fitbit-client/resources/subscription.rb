# frozen_string_literal: true

module FitbitClient
  module Resources
    module Subscription
      def subscribe(activity_type, subscription_id)
        post(path_user_version(path: "/#{activity_type}/apiSubscriptions/#{subscription_id}"))
      end
    end
  end
end
