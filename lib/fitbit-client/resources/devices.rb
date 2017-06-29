# frozen_string_literal: true

module FitbitClient
  module Resources
    module Devices
      # GET https://api.fitbit.com/1/user/-/devices.json
      #
      def devices
        get_json(path_user_version(path: '/devices'))
      end
    end
  end
end
