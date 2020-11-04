# frozen_string_literal: true
# see https://developer.pagerduty.com/docs/events-api-v2/trigger-events/

require File.join(File.dirname(__FILE__), 'connection.rb')
require 'time'

class PagerdutyEventsHelper
  attr_accessor :connection

  TRIGGER_URL_PATH = 'v2/enqueue'
  
  def initialize
    @connection = PAGERDUTY_CLIENT
  end

  def post_to_pagerduty(url_path, params)
    @connection.post(url_path) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['From'] = 'opsmonitor@enova.com'
      req.body = params.to_json
    end
  end

  def trigger_event(params=nil)
    params = params || testing_params
    # insure the event action is trigger
    params[:event_action] = 'trigger'
    final_params = event_params(params)
    post_to_pagerduty(TRIGGER_URL_PATH, final_params)
  end

  def acknowledge_event()
  end

  def resolve_event
  end

  def event_params(params)
    {
      "payload": {
        "summary": params[:summary],
        "timestamp": params[:timestamp] || Time.now.iso8601,
        "source": params[:source],
        "severity": params[:severity],
        "component": params[:component],
        "group": params[:group],
        "class": params[:class],
        "custom_details": params[:custom_details_hash]
      },
      "routing_key": params[:routing_key],
      "dedup_key": params[:dedup_key],
      "images": params[:images_array],
      "links": params[:links_array],
      "event_action": params[:event_action],
      "client": params[:client],
      "client_url": params[:client_url]
    }
  end

  def testing_params
    { summary: 'a summary',
      source: 'some source',
      severity: 'error',
      component: 'some component',
      group: 'some group',
      class: 'some class',
      routing_key: 'some_routing_key',
      client: 'some client',
      client_url: 'some_client_url' }
  end
end
