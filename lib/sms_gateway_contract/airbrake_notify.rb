module SmsGatewayContract
  module AirbrakeNotify
    def self.send_sms(number:, country:, body:)
      Airbrake.notify("login_code #{code} for #{country} #{number}")
    end
  end
end
