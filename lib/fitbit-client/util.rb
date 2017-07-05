# frozen_string_literal: true

module FitbitClient
  module Util
    def empty_str?(obj)
      obj.nil? || obj.empty?
    end

    def path_user_version(path, options = {})
      user_id = options[:user_id] || '-'
      version = options[:version] || '1'
      "/#{version}/user/#{user_id}#{path}.json"
    end

    def date_iso(date)
      date.iso8601
    end

    module_function :empty_str?, :date_iso, :path_user_version
  end
end
