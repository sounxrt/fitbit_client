module FitbitClient
  module Resources
    module Devices
      # GET https://api.fitbit.com/1/user/-/devices.json
      #
      def devices
        get(path_user_version('/devices'))
      end
    end
  end
end
