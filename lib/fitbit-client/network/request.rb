module FitbitClient
  module Network
    module Request
      def get(path, params = {}, headers = {})
        parse_response(request(:get, path, headers: headers, params: params))
      end

      def post(path, headers = {})
        request(:post, path, headers: headers)
      end

      def delete(path, headers = {})
        request(:delete, path, headers: headers)
      end

      private

      def request(http_method, path, opts = {})
        tried = 0
        begin
          tried += 1
          oauth2_access_token.request(http_method, path, opts)
        rescue OAuth2::Error => e
          # Handle refresh token issue automagically
          if expired_token_error?(e.response)
            oauth2_refresh_token!
            retry if tried < 2
          end
          raise FitbitClient::Error.new('Error during OAuth2 request', e.response)
        end
      end

      def parse_response(response)
        return {} if response.nil? || response.body.nil? || response.body.empty?
        JSON.parse response.body
      end

      def expired_token_error?(response)
        json_response = parse_response(response)
        json_response.dig('errors').dig(0).dig('errorType') == 'expired_token'
      end

      def oauth2_refresh_token!
        @oauth2_access_token = oauth2_access_token.refresh!
        refresh_token_callback!(@oauth2_access_token)
      rescue OAuth2::Error => e
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
