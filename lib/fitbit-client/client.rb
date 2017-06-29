# frozen_string_literal: true

require 'oauth2'

module FitbitClient
  class Client
    include FitbitClient::Util
    include FitbitClient::Network::Request
    include FitbitClient::Resources

    attr_reader :client_id, :client_secret
    attr_accessor :access_token, :refresh_token

    def initialize(access_token, refresh_token, options = {})
      @access_token = access_token
      @refresh_token = refresh_token
      @client_id = options.fetch(:client_id, FitbitClient.client_id)
      @client_secret = options.fetch(:client_secret, FitbitClient.client_secret)
      raise ArgumentError, 'FitbitClient::Client cannot operate without a client_id and client_secret values' if empty_str?(@client_id) || empty_str?(@client_secret)
    end

    def debug_mode!(enable)
      if enable
        @original_oauth_debug = ENV['OAUTH_DEBUG']
        ENV['OAUTH_DEBUG'] = 'true'
      else
        ENV['OAUTH_DEBUG'] = @original_oauth_debug if @original_oauth_debug
      end
    end

    def refresh_token!
      oauth2_refresh_token!
    end

    attr_writer :refresh_token_callback

    def refresh_token_callback!(oauth2_token)
      @refresh_token_callback&.call(oauth2_token)
    end
  end
end
