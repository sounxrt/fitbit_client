# frozen_string_literal: true

module FitbitClient
  class AuthorizationGrantFlow
    attr_reader :client_id, :client_secret

    def initialize(options = {})
      @client_id = options.fetch(:client_id, FitbitClient.client_id)
      @client_secret = options.fetch(:client_secret, FitbitClient.client_secret)
    end

    def get_token(code, redirect_url)
      oauth2_client.get_token(grant_type: 'authorization_code', code: code, redirect_uri: redirect_url)
    end

    def oauth2_client
      @oauth2_client ||= OAuth2::Client.new(client_id, client_secret, OAUTH2_CLIENT_OPTIONS)
    end

    def client_identification_uri(redirect_url, scopes)
      params = URI.encode("?response_type=code&client_id=#{FitbitClient.client_id}&scope=#{scopes}")
      "#{FitbitClient::OAUTH2_CLIENT_OPTIONS[:authorize_url]}/#{params}&redirect_uri=#{redirect_uri_param(redirect_url)}"
    end

    private

    def redirect_uri_param(redirect_url)
      URI.encode_www_form_component(redirect_url).to_s
    end
  end
end
