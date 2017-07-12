# frozen_string_literal: true

require 'fitbit_client/version'
require 'fitbit_client/error'
require 'fitbit_client/token_error'
require 'fitbit_client/util'
require 'fitbit_client/network/request'

# Resources
require 'fitbit_client/resources/common'
require 'fitbit_client/resources/activity'
require 'fitbit_client/resources/body_and_weight'
require 'fitbit_client/resources/devices'
require 'fitbit_client/resources/sleep'
require 'fitbit_client/resources/subscription'
require 'fitbit_client/resources'

# The main client
require 'fitbit_client/client'
require 'fitbit_client/authorization_grant_flow'

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

    def debug_mode!(enable)
      ENV['OAUTH_DEBUG'] = enable ? 'true' : 'false'
    end
  end

  def self.configure
    yield self
  end
end
