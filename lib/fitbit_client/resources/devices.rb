# frozen_string_literal: true

module FitbitClient
  module Resources
    module Devices
      # The Get Device endpoint returns a list of the Fitbit devices connected
      # to a user's account.
      #
      # Third-party applications can check when a Fitbit device last synced
      # with Fitbit's servers using this endpoint.
      def devices(options = {})
        get_json(path_user_version('/devices', options))
      end

      # Returns a list of the set alarms connected to a user's account.
      #   tracker_id : The ID of the tracker for which data is returned. The tracker-id value is found via the Get Devices endpoint.
      def alarms(tracker_id, options = {})
        get_json(path_user_version("/devices/tracker/#{tracker_id}/alarms", options))
      end
    end
  end
end
