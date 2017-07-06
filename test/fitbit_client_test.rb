# frozen_string_literal: true

require 'test_helper'

class FitbitClientTest < Minitest::Test # :nodoc:
  def test_that_it_has_a_version_number
    refute_nil ::FitbitClient::VERSION
  end
end
