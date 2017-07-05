# frozen_string_literal: true

module FitbitClient
  module Resources
    module Sleep
      # TODO: This endpoint is going to be deprecated, should be replaced
      #
      def sleep_resource_for_time_series(resource, date, period, options = {})
        path = "/sleep/#{resource}/date/#{date_iso(date)}/#{period}"
        get_json(path_user_version(path, options))
      end

      # The Get Sleep Logs by Date endpoint returns a summary and list
      # of a user's sleep log entries (including naps) as well as detailed sleep
      # entry data for a given day.
      #
      # This endpoint supports two kinds of sleep data:
      # - stages: Levels data is returned with 30-second granularity. 'Sleep Stages' levels include deep, light, rem, and wake.
      # - classic: Levels data returned with 60-second granularity. 'Sleep Pattern' levels include asleep, restless, and awake.
      #
      # The response could be a mix of classic and stages sleep logs.
      #
      # <b>Note:</b> shortData is only included for stages sleep logs and
      # includes wake periods that are 3 minutes or less in duration.
      #
      # This distinction is to simplify graphically distinguishing short wakes
      # from longer wakes, but they are physiologically equivalent.
      def sleep_logs_by_date(date, options = {})
        path = "/sleep/date/#{date_iso(date)}"
        options[:version]  = '1.2'
        get_json(path_user_version(path, options))
      end

      # The Get Sleep Logs by Date Range endpoint returns a list of a user's
      # sleep log entries (including naps) as well as detailed sleep entry data
      # for a given date range (inclusive of start and end dates).
      #
      # This endpoint supports two kinds of sleep data:
      # - stages : Levels data is returned with 30-second granularity. 'Sleep Stages' levels include deep, light, rem, and wake.
      # - classic : Levels data returned with 60-second granularity. 'Sleep Pattern' levels include asleep, restless, and awake.
      #
      # The response could be a mix of classic and stages sleep logs.
      #
      # <b>Note:</b> shortData is only included for stages sleep logs and
      # includes wake periods that are 3 minutes or less in duration.
      #
      # This distinction is to simplify graphically distinguishing short wakes
      # from longer wakes, but they are physiologically equivalent.
      def sleep_logs_by_date_range(start_date, end_date, options = {})
        path = "/sleep/date/#{date_iso(start_date)}/#{date_iso(end_date)}"
        options[:version] = '1.2'
        get_json(path_user_version(path, options))
      end

      # The Get Sleep Logs List endpoint returns a list of a user's sleep logs
      # (including naps) before or after a given day with offset, limit, and sort order.
      #
      # This endpoint supports two kinds of sleep data:
      # - stages : Levels data is returned with 30-second granularity. 'Sleep Stages' levels include deep, light, rem, and wake.
      # - classic : Levels data returned with 60-second granularity. 'Sleep Pattern' levels include asleep, restless, and awake.
      #
      # The response could be a mix of classic and stages sleep logs.
      #
      # <b>Note:</b> shortData is only included for stages sleep logs and
      # includes wake periods that are 3 minutes or less in duration.
      #
      # This distinction is to simplify graphically distinguishing short wakes
      # from longer wakes, but they are physiologically equivalent.
      def sleep_logs_list(before_date, after_date, sort, limit, options = {})
        raise 'Before date and Atfer date cannot both be specified' if before_date && after_date
        if before_date
          params = { 'beforeDate' => date_iso(before_date), 'sort' => sort, 'limit' => limit, 'offset' => 0 }
        elsif after_date
          params = { 'afterDate' => date_iso(after_date), 'sort' => sort, 'limit' => limit, 'offset' => 0 }
        end
        options[:version] = '1.2'
        get_json(path_user_version('/sleep/list', options), params)
      end

      def log_sleep

      end

      def delete_sleep_log

      end

      # The Get Sleep Goal endpoint returns a user's current sleep goal using
      # unit in the unit system that corresponds to the Accept-Language header
      # provided in the format requested.
      def sleep_goals
        get_json(path_user_version('/sleep/goal'))
      end

      def update_sleep_goals

      end

    end
  end
end
