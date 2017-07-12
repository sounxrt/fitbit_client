# frozen_string_literal: true

module FitbitClient
  module Resources
    module Common
      def path_user_version(path, options = {})
        version = options.fetch(:version, '1')
        return "/#{version}#{path}.json" if options[:skip_user]

        # Add user id
        user_id = options.fetch(:user_id, '-')
        "/#{version}/user/#{user_id}#{path}.json"
      end

      def skip_user_options!(options)
        options[:skip_user] = true
        options.delete(:user_id) if options.key?(:user_id)
      end

      def time_series_path(type, resource, date, end_limit)
        "/#{type}/#{resource}/date/#{iso_date(date)}/#{end_limit}"
      end

      def period_or_date_param(period_or_date)
        period_or_date.is_a?(Date) ? iso_date(period_or_date) : period_or_date
      end
    end
  end
end
