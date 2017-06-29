# frozen_string_literal: true

module FitbitClient
  module Resources
    module Activity
      # The Get Lifetime Stats endpoint retrieves the user's activity statistics
      # in the format requested using units in the unit system which corresponds
      # to the Accept-Language header provided.
      #
      # Activity statistics includes Lifetime and Best achievement values
      # from the My Achievements tile on the website dashboard.
      #
      # Response contains both statistics from the tracker device and
      # total numbers including tracker data and manual activity log entries
      # as seen on the Fitbit website dashboard.
      #
      def lifetime_stats(user_id = nil)
        get_json(path_user_version(user_id: user_id, path: '/activities'))
      end

      # The Get Daily Activity Summary endpoint retrieves a summary and list
      # of a user's activities and activity log entries for a given day in the
      # format requested using units in the unit system which corresponds to
      # the Accept-Language header provided.
      #
      def daily_activity_summary(user_id = nil, date)
        get_json(path_user_version(user_id: user_id, path: "/activities/date/#{date_iso(date)}"))
      end

      # The Get Activity Time Series endpoint returns time series data in
      # the specified range for a given resource in the format requested
      # using units in the unit system that corresponds to
      # the Accept-Language header provided.
      #
      def activity_time_series(user_id = nil, resource, date, period_or_end_date)
        period = period_or_end_date.is_a?(Date) ? date_iso(period_or_end_date) : period_or_end_date
        path = "/activities/#{resource}/date/#{date_iso(date)}/#{period}"
        get_json(path_user_version(user_id: user_id, path: path))
      end

      # Get a tree of all valid Fitbit public activities from the activities
      # catalog as well as private custom activities the user created in the
      # format requested.
      #
      # If the activity has levels, also get a list of activity level details.
      #
      def browse_activity_types
        get_json(path_user_version(path: '/activities'))
      end
    end
  end
end
