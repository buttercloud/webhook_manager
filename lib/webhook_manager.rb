# frozen_string_literal: true

require "faraday"
require "json"

require_relative "webhook_manager/version"
require_relative "webhook_manager/globals"

module WebhookManager
  class Error < StandardError; end

  class Webhook
    attr_accessor :conn

    def initialize(api_key)
      @conn = Faraday::Connection.new(
        url: HOOKY_API,
        headers: {
          "Authorization" => "ApiKey #{api_key}",
          "Content-Type" => "application/json"
        }
      )
    end

    def trigger!(event_name:, payload:)
      begin
        res = @conn.post("webhook_events/trigger", {webhook_event: { event_name: event_name, event_payload: payload }}.to_json)
      rescue Faraday::ConnectionFailed => e
        raise Error.new("Could not connect to API")
      rescue Faraday::TimeoutError => e
        raise Error.new("Time out error")
      end

      handle_reponse(res)
    end

    def update_status(event_id:, status:)
      begin
        res = @conn.post("webhook_events/update_status", { event_id: event_id, event_status: status }.to_json)
      rescue Faraday::ConnectionFailed => e
        raise Error.new("Could not connect to API")
      rescue Faraday::TimeoutError => e
        raise Error.new("Time out error")
      end

      handle_reponse(res)
    end

    private

    def handle_reponse(res)
      if res.status == 200
        data = JSON.parse(res.body)

        case data["status"]
        when "ERROR"
          raise "Something went wrong: #{data["errors"].join(", ")}"
        when "OK"
          true
        end
      elsif res.status == 401
        raise Error.new("Unauthorized access to the API!")
      else
        raise Error.new("Something went wrong calling the hooky API! #{res.body}")
      end
    end
  end
end
