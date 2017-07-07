# frozen_string_literal: true

module FitbitClient
  # This module is used to include all resources (endpoints)
  module Resources
    include FitbitClient::Util
    include FitbitClient::Network::Request
    include FitbitClient::Resources::Activity
    include FitbitClient::Resources::BodyAndWeight
    include FitbitClient::Resources::Devices
    include FitbitClient::Resources::Sleep
    include FitbitClient::Resources::Subscription
  end
end
