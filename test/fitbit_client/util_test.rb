require 'test_helper'

module FitbitClient
  class UtilTest < Minitest::Test
    def test_iso_date
      assert_equal '2017-02-03', client.send(:iso_date, Date.parse('2017-02-03'))
    end

    def test_iso_time
      assert_equal '14:01', client.send(:iso_time, Time.new(2017, 4, 5, 14, 1, 1, '+02:00'))
    end

    def test_iso_time_with_seconds
      assert_equal '14:01:59', client.send(:iso_time_with_seconds, Time.new(2017, 4, 5, 14, 1, 59, '+02:00'))
    end
  end
end
