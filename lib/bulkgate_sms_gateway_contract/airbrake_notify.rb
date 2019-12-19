module BulkgateSmsGatewayContract
  module AirbrakeNotify
    def self.send_sms(number:, country:, body:, sender_name: nil)
      msg = "BulkgateSmsGatewayContract: login_code #{code} for #{country} #{number}"
      msg += " | SENDER #{sender_name}" if sender_name
      Airbrake.notify(msg)
    end
  end
end
