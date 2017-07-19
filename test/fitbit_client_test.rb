# frozen_string_literal: true

require 'test_helper'

class FitbitClientTest < Minitest::Test # :nodoc:
  def test_that_it_has_a_version_number
    refute_nil ::FitbitClient::VERSION
  end

  def test_configure
    assert_equal FitbitClient, FitbitClient.configure { |config| config }
  end

  def test_debug_mode!
    refute ENV['OAUTH_DEBUG']
    FitbitClient.debug_mode! true
    assert ENV['OAUTH_DEBUG']
    FitbitClient.debug_mode! false
    refute ENV['OAUTH_DEBUG']
  end
end
