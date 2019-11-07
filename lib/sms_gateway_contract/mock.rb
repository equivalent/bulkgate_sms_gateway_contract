module SmsGatewayContract
  module Mock
    def self.send_sms(number:, body:, country:)
      "#{body} TO: '#{country}:#{number}'"
    end
  end
end
