# frozen_string_literal: true

require "faraday"
require "json"

require_relative "webhook_manager/version"

module WebhookManager
  class Error < StandardError; end

  class Webhook
    attr_accessor :conn

    def initialize(url, api_key)
      @conn = Faraday::Connection.new(
        url: url,
        headers: {
          "Authorization" => "ApiKey #{api_key}",
          "Content-Type" => "application/json"
        }
      )
    end

    def trigger!(event_name:, payload:)
      res = @conn.post("webhook_events/trigger", { event_name: event_name, event_payload: payload }.to_json)

      handle_reponse(res)
    end

    def update_status(event_id:, status:)
      res = @conn.post("webhook_events/update_status", { event_id: event_id, status: status }.to_json)

      handle_reponse(res)
    end

    private

    def handle_reponse(res)
      if res.status == 200
        data = JSON.parse(res.body)

        if data["status"] == "ERROR"
          raise "Something went wrong: #{data["errors"].join(", ")}"
        elsif data["status"] == "OK"
          true
        end
      else
        raise Error.new("Something went wrong calling the hooky API!")
      end
    end
  end
end
