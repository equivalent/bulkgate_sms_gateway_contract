module BulkgateSmsGatewayContract
  module Mock
    def self.send_sms(number:, body:, country:, sender_name: nil)
      msg = "BULKGATE: #{body} TO: '#{country}:#{number}'"
      msg +=  " SENDER: #{sender_name}" if sender_name
      msg
    end
  end
end
