# frozen_string_literal: true

require 'oauth2'

module FitbitClient
  class Client
    include FitbitClient::Resources

    attr_writer :refresh_token_callback
    attr_reader :client_id, :client_secret, :access_token, :refresh_token

    def initialize(access_token, refresh_token, options = {})
      @access_token = access_token
      @refresh_token = refresh_token
      @client_id = options.fetch(:client_id, FitbitClient.client_id)
      @client_secret = options.fetch(:client_secret, FitbitClient.client_secret)
      raise ArgumentError, 'FitbitClient::Client cannot operate without a client_id and client_secret values' if empty_str?(@client_id) || empty_str?(@client_secret)
    end

    # Force a refresh token
    def refresh_token!
      oauth2_refresh_token!
    end

    # When a new refresh token is received this method will be called with the
    # OAuth2::AccessToken instance as argument
    def refresh_token_callback!(oauth2_token)
      @access_token = oauth2_token.token
      @refresh_token = oauth2_token.refresh_token
      @refresh_token_callback&.call(oauth2_token)
    end
  end
end
