# frozen_string_literal: true

module FitbitClient
  module Util
    def empty_str?(obj)
      obj.nil? || obj.empty?
    end

    # Convert a Date object to a iso8601 format String (yyyy-MM-dd)
    def iso_date(date)
      date.iso8601
    end

    def iso_time(time)
      time.strftime('%H:%M')
    end

    def iso_time_with_seconds(time)
      time.strftime('%H:%M:%S')
    end

    module_function :empty_str?, :iso_date, :iso_time, :iso_time_with_seconds
  end
end
