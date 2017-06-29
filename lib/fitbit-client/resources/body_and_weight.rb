# frozen_string_literal: true

module FitbitClient
  module Resources
    module BodyAndWeight
      def weight_logs(date)
        get(path_user_version("/body/log/weight/date/#{api_date(date)}"))
      end
    end
  end
end
