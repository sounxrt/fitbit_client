# frozen_string_literal: true

require 'test_helper'

module FitbitClient
  module Resources
    class SleepTest < Minitest::Test # :nodoc:
      def test_sleep_time_series
        VCR.use_cassette('sleep_time_series_v1') do
          response = client.sleep_time_series('timeInBed', Date.parse('2017-07-07'), '1w')
          assert_equal '2017-07-01', response['sleep-timeInBed'][0]['dateTime']
          assert_equal '2017-07-02', response['sleep-timeInBed'][1]['dateTime']
          assert_equal '2017-07-03', response['sleep-timeInBed'][2]['dateTime']
          assert_equal '2017-07-04', response['sleep-timeInBed'][3]['dateTime']
          assert_equal '2017-07-05', response['sleep-timeInBed'][4]['dateTime']
          assert_equal '2017-07-06', response['sleep-timeInBed'][5]['dateTime']
          assert_equal '2017-07-07', response['sleep-timeInBed'][6]['dateTime']
          assert_equal '0', response['sleep-timeInBed'][0]['value']
          assert_equal '0', response['sleep-timeInBed'][1]['value']
          assert_equal '0', response['sleep-timeInBed'][2]['value']
          assert_equal '0', response['sleep-timeInBed'][3]['value']
          assert_equal '0', response['sleep-timeInBed'][4]['value']
          assert_equal '486', response['sleep-timeInBed'][5]['value']
          assert_equal '0', response['sleep-timeInBed'][6]['value']
        end
      end

      def test_sleep_logs_by_date
        VCR.use_cassette('sleep_logs_by_date') do
          response = client.sleep_logs_by_date(Date.parse('2017-07-06'))
          refute_nil response['sleep']
          assert_equal 60, response['summary']['stages']['deep']
          assert_equal 316, response['summary']['stages']['light']
          assert_equal 41, response['summary']['stages']['rem']
          assert_equal 69, response['summary']['stages']['wake']
        end
      end

      def test_sleep_logs_by_date_range
        VCR.use_cassette('sleep_logs_by_date_range') do
          response = client.sleep_logs_by_date_range(Date.parse('2017-07-01'), Date.parse('2017-07-07'))
          refute_nil response['sleep']
        end
      end

      def test_sleep_logs_list
        VCR.use_cassette('sleep_logs_list') do
          response = client.sleep_logs_list(Date.parse('2017-07-07'), nil, :desc, 10)
          assert_equal '2017-07-07', response['pagination']['beforeDate']
          refute_nil response['sleep']
        end
      end

      def test_log_sleep
        VCR.use_cassette('log_sleep') do
          time = Time.new(2017, 7, 6, 23, 30)
          response = client.log_sleep(time, 26_280_000, time.to_date)
          assert_equal 26_280_000, response['sleep']['duration']
          refute_nil response['sleep']['logId']
        end
      end

      def test_delete_sleep_log
        VCR.use_cassette('delete_sleep_log') do
          assert client.delete_sleep_log(15_143_410_812)
        end
      end

      def test_sleep_goals
        VCR.use_cassette('sleep_goals') do
          response = client.sleep_goals
          assert response.key?('consistency')
          assert response.key?('goal')
        end
      end

      def test_update_sleep_goals
        VCR.use_cassette('update_sleep_goals') do
          response = client.update_sleep_goals(420)
          assert_equal(420, response['goal']['minDuration'])
        end
      end
    end
  end
end
