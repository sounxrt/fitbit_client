# frozen_string_literal: true

module FitbitClient
  module Resources
    module BodyAndWeight
      def weight_logs(date)
        get_json(path_user_version(path: "/body/log/weight/date/#{date_iso(date)}"))
      end
    end
  end
end
