# frozen_string_literal: true

module FitbitClient
  module Resources
    module Sleep
      # TODO: This endpoint is going to be deprecated, should be replaced
      #
      def sleep_resource_for_time_series(user_id = nil, resource, date, period)
        path = "/sleep/#{resource}/date/#{date_iso(date)}/#{period}"
        get_json(path_user_version(user_id: user_id, path: path))
      end

      def sleep_logs_by_date(user_id = nil, date)
        path = "/sleep/date/#{date_iso(date)}"
        get_json(path_user_version(user_id: user_id, version: '1.2', path: path))
      end

      def sleep_logs_by_date_range(user_id = nil, start_date, end_date)
        path = "/sleep/date/#{date_iso(start_date)}/#{date_iso(end_date)}"
        get_json(path_user_version(user_id: user_id, version: '1.2', path: path))
      end

      def sleep_logs_list(user_id = nil, before_date, after_date, sort, limit)
        raise 'Before date and Atfer date cannot both be specified' if before_date && after_date
        if before_date
          params = { 'beforeDate' => date_iso(before_date), 'sort' => sort, 'limit' => limit, 'offset' => 0 }
        elsif after_date
          params = { 'afterDate' => date_iso(after_date), 'sort' => sort, 'limit' => limit, 'offset' => 0 }
        end
        get_json(path_user_version(user_id: user_id, version: '1.2', path: '/sleep/list'), params)
      end
    end
  end
end
