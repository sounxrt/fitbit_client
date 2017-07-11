# frozen_string_literal: true

require 'fitbit-client/version'
require 'fitbit-client/error'
require 'fitbit-client/util'
require 'fitbit-client/network/request'

# Resources
require 'fitbit-client/resources/common'
require 'fitbit-client/resources/activity'
require 'fitbit-client/resources/body_and_weight'
require 'fitbit-client/resources/devices'
require 'fitbit-client/resources/sleep'
require 'fitbit-client/resources/subscription'
require 'fitbit-client/resources'

# The main client
require 'fitbit-client/client'
require 'fitbit-client/authorization_grant_flow'

# The authorization grant flow
module FitbitClient
  OAUTH2_CLIENT_OPTIONS = { site: 'https://api.fitbit.com',
                            token_url: 'https://api.fitbit.com/oauth2/token',
                            authorize_url: 'https://www.fitbit.com/oauth2/authorize',
                            auth_scheme: :basic_auth }.freeze

  VALID_SCOPES = %w(activity heartrate location nutrition profile settings sleep social weight).freeze
  VALID_SUBSCRIPTIONS = %i(activities body foods sleep).freeze

  @default_locale = 'en_US'
  @default_language = 'en_US'

  class << self
    attr_accessor :client_id, :client_secret
    attr_accessor :default_language, :default_locale
  end

  def self.configure
    yield self
  end
end
