# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'yaml'

config_path = File.join(File.dirname(File.expand_path('..', __FILE__)), '.config.yml')
PAGERDUTY_CONFIG = YAML.load(File.read(config_path))[:pagerduty_events_helper]

PAGERDUTY_CLIENT = Faraday.new('https://events.pagerduty.com') do |f|
  f.headers['Accept'] = 'application/vnd.pagerduty+json;version=2'
  f.headers['Authorization'] = "Token token=#{PAGERDUTY_CONFIG['token']}"
  f.response :json, :content_type => /\bjson$/

  f.adapter :net_http
end
