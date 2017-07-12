require 'test_helper'

module FitbitClient
  module Resources
    class CommonTest < Minitest::Test
      def test_skip_user_options!
        options = { user_id: 123 }
        client.skip_user_options!(options)
        assert options[:skip_user]
        assert_nil options[:user_id]
      end

      def test_period_or_date_param
        assert_equal '2017-02-03', client.period_or_date_param(Date.parse('2017-02-03'))
        assert '7d', client.period_or_date_param('7d')
      end

      def test_time_series_path
        assert_equal '/body/bmi/date/2017-02-03/7d', client.time_series_path('body', 'bmi', Date.parse('2017-02-03'), '7d')
        assert_equal '/body/bmi/date/2017-02-03/2017-02-06', client.time_series_path('body', 'bmi', Date.parse('2017-02-03'), Date.parse('2017-02-06'))
      end

      def test_path_user_version
        assert_equal '/1/user/-/activities.json', client.path_user_version('/activities')
        assert_equal '/1/activities.json', client.path_user_version('/activities', skip_user: true)
        assert_equal '/1/user/qwer/activities.json', client.path_user_version('/activities', user_id: 'qwer')
      end
    end
  end
end

