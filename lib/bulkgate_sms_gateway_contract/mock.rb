module BulkgateSmsGatewayContract
  module Mock
    def self.send_sms(number:, body:, country:, sender_name: nil)
      BulkgateSmsGatewayContract::FakeContractCommonalities
        .raise_when_invalid(country: country, body: body, number: number)

      msg = "BULKGATE: #{body} TO: '#{country}:#{number}'"
      msg +=  " SENDER: #{sender_name}" if sender_name
      msg
    end
  end
end
