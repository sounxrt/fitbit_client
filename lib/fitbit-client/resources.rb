# frozen_string_literal: true

module FitbitClient
  module Resources
    include FitbitClient::Util
    include FitbitClient::Network::Request
    include Activity
    include BodyAndWeight
    include Devices
    include Sleep
    include Subscription
  end
end
