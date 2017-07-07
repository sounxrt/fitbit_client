# frozen_string_literal: true

module FitbitClient
  module Util
    def empty_str?(obj)
      obj.nil? || obj.empty?
    end

    def path_user_version(path, options = {})
      version = options.fetch(:version, '1')
      return "/#{version}#{path}.json" if options[:skip_user]

      # Add user id
      user_id = options.fetch(:user_id, '-')
      "/#{version}/user/#{user_id}#{path}.json"
    end

    def skip_user_options!(options)
      options[:skip_user] = true
      options.delete![:user_id] if options.key?(:user_id)
    end

    def period_or_date_param(period_or_date)
      period_or_date.is_a?(Date) ? iso_date(period_or_date) : period_or_date
    end

    # Convert a Date object to a iso8601 format String (yyyy-MM-dd)
    def iso_date(date)
      date.iso8601
    end

    def iso_time(time)
      time.strftime('%H:%M')
    end

    def iso_time_with_seconds(time)
      time.strftime('%H:%M:%S')
    end

    module_function :empty_str?, :iso_date, :iso_time, :iso_time_with_seconds, :path_user_version
  end
end
