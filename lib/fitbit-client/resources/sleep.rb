# frozen_string_literal: true

module FitbitClient
  module Resources
    module Sleep
      # The Get Sleep Time Series endpoint returns time series data in the
      # specified range for a given resource in the format requested using units
      # in the unit system that corresponds to the Accept-Language header provided.
      #
      # API Version: 1
      #
      # <b>Note:</b> This API has been <b>deprecated</b> with the introduction
      # of version 1.2 of the \Sleep APIs described above. \Sleep Stages data
      # cannot be retrieved with this API. If your application requires data
      # consistency while you transition over to the version 1.2 \Sleep APIs,
      # you can get this data through the version 1 Get Sleep Logs by Date
      # endpoint.
      #
      #   resource           : startTime | timeInBed | minutesAsleep |
      #                        awakeningsCount | minutesAwake | minutesToFallAsleep
      #                        minutesAfterWakeup | efficiency
      #   date               : The start date for a range or end date of the period specified
      #   period_or_end_date : One of  1d, 7d, 30d, 1w, 1m, 3m, 6m, 1y, max or the end date of the range
      def sleep_time_series(resource, date, period_or_end_date, options = {})
        end_limit = period_or_date_param(period_or_end_date)
        path = time_series_path('sleep', resource, date, end_limit)
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
        path = "/sleep/date/#{iso_date(date)}"
        options[:version] = '1.2' unless options.key?(:version)
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
        path = "/sleep/date/#{iso_date(start_date)}/#{iso_date(end_date)}"
        options[:version] = '1.2' unless options.key?(:version)
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
      #
      #   before_date : Either beforeDate or afterDate must be specified.
      #                 Set sort to desc when using beforeDate.
      #   after_date  : Either beforeDate or afterDate must be specified.
      #                 Set sort to asc when using afterDate.
      def sleep_logs_list(before_date, after_date, sort, limit, options = {})
        raise 'Before date and Atfer date cannot both be specified' if before_date && after_date
        if before_date
          params = { 'beforeDate' => iso_date(before_date), 'sort' => sort, 'limit' => limit, 'offset' => 0 }
        elsif after_date
          params = { 'afterDate' => iso_date(after_date), 'sort' => sort, 'limit' => limit, 'offset' => 0 }
        end
        options[:version] = '1.2' unless options.key?(:version)
        get_json(path_user_version('/sleep/list', options), params)
      end

      # The Log Sleep endpoint creates a log entry for a sleep event and
      # returns a response in the format requested. Keep in mind that it is NOT
      # possible to create overlapping log entries.
      #
      # The dateOfSleep in the response for the sleep log is the date on which
      # the sleep event ends.

      # It requires read & write access
      def log_sleep(start_time, duration_milliseconds, date, options = {})
        params = { 'date' => iso_date(date), 'startTime' => start_time.strftime('%H:%M'), 'duration' => duration_milliseconds }
        options[:version] = '1.2' unless options.key?(:version)
        post_json(path_user_version('/sleep'), params)
      end

      # The Delete Sleep Log endpoint deletes a user's sleep log entry with the
      # given ID.
      def delete_sleep_log(log_id)
        successful_delete?(delete(path_user_version("/sleep/#{log_id}")))
      end

      # The Get Sleep Goal endpoint returns a user's current sleep goal using
      # unit in the unit system that corresponds to the Accept-Language header
      # provided in the format requested.
      def sleep_goals
        get_json(path_user_version('/sleep/goal'))
      end

      # Creates or updates a user's sleep goal and get a response in the in the
      # format requested.
      #
      # Access Type: Read & Write
      #
      #   min_duration_minutes : The target sleep duration is in minutes
      def update_sleep_goals(min_duration_minutes)
        post_json(path_user_version('/sleep/goal'), 'minDuration' => min_duration_minutes)
      end
    end
  end
end
