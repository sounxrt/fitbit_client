# frozen_string_literal: true

module FitbitClient
  module Network
    module Request
      def get_json(path, params = {}, headers = {})
        parse_response(get(path, params, headers))
      end

      def get(path, params = {}, headers = {})
        request(:get, path, headers: headers, params: params)
      end

      def post_json(path, params = {}, headers = {})
        parse_response(post(path, params, headers))
      end

      def post(path, params = {}, headers = {})
        request(:post, path, headers: headers, params: params)
      end

      def delete_json(path, params = {}, headers = {})
        parse_response(delete(path, params, headers))
      end

      def delete(path, params = {}, headers = {})
        request(:delete, path, headers: headers, params: params)
      end

      def successful_post?(response)
        response.status == 201 && response.body == '{}'
      end

      def successful_delete?(response)
        response.status == 204 && response.body.empty?
      end

      private

      def request(method, path, opts = {})
        attempt = 0
        begin
          default_request_headers(opts)
          oauth2_access_token.request(method, path, opts)
        rescue OAuth2::Error => e # Handle refresh token issue automagically
          attempt += 1
          parsed_response = parse_response(e.response)
          if expired_token_error?(parsed_response)
            oauth2_refresh_token!
            retry if attempt < 2
          end
          check_unrecoverable_token(parsed_response, e)
          raise FitbitClient::Error.new('Error during OAuth2 request', e.response)
        end
      end

      def default_request_headers(opts)
        opts[:headers]['User-Agent'] = "FitbitClient v#{::FitbitClient::VERSION}"
        opts[:headers]['Accept-Language'] = opts.fetch(:language, ::FitbitClient.default_language)
        opts[:headers]['Accept-Locale'] = opts.fetch(:locale, ::FitbitClient.default_locale)
      end

      def parse_response(response)
        return {} if response.nil? || response.body.nil? || response.body.empty?
        if response.status == 200
          JSON.parse response.body
        else
          raise FitbitClient::Error.new('Fitbit request unsuccessful', response)
        end
      end

      def check_unrecoverable_token(parsed_response, error)
        if invalid_token_error?(parsed_response, 'invalid_grant', 'Refresh token invalid') ||
           invalid_token_error?(parsed_response, 'invalid_token', 'Access token invalid')
          raise FitbitClient::TokenError.new('Invalid token', error.response)
        end
      end

      def expired_token_error?(parsed_response)
        parsed_response.dig('errors', 0, 'errorType') == 'expired_token'
      end

      def invalid_token_error?(parsed_response, error_type, error_message)
        message = parsed_response.dig('errors', 0, 'message')
        return unless message
        parsed_response.dig('errors', 0, 'errorType') == error_type &&
          message.start_with?(error_message)
      end

      def oauth2_refresh_token!
        @oauth2_access_token = oauth2_access_token.refresh!
        refresh_token_callback!(@oauth2_access_token)
      rescue OAuth2::Error => e
        parsed_response = parse_response(e.response)
        check_unrecoverable_token(parsed_response, e)
        raise FitbitClient::Error.new('Error during oauth2_refresh_token! attempt', e.response)
      end

      def oauth2_access_token
        @oauth2_access_token ||= OAuth2::AccessToken.new(oauth2_client, access_token, refresh_token: refresh_token)
      end

      def oauth2_client
        @oauth2_client ||= OAuth2::Client.new(client_id, client_secret, FitbitClient::OAUTH2_CLIENT_OPTIONS)
      end
    end
  end
end
