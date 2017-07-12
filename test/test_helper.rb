# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end

require 'pry'
require 'fitbit_client'
require 'minitest/autorun'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :faraday
end

def client
  @client ||= FitbitClient::Client.new('token', 'refresh_token', client_id: '1234567', client_secret: 'qwertyuiopoiuytr123456')
end
