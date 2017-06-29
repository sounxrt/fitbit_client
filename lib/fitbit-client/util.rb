# frozen_string_literal: true

module FitbitClient
  module Util
    def empty_str?(obj)
      obj.nil? || obj.empty?
    end

    def path_user_version(path: , user_id: nil, version: '1')
      if user_id
        "/#{version}/user/#{user_id}#{path}.json"
      else
        "/#{version}/user/-#{path}.json"
      end
    end

    def date_iso(date)
      date.iso8601
    end

    module_function :empty_str?, :date_iso, :path_user_version
  end
end
