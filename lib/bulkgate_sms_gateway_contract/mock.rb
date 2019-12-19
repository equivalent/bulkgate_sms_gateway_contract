module BulkgateSmsGatewayContract
  module Mock
    def self.send_sms(number:, body:, country:, sender_name: nil)
      BulkgateSmsGatewayContract::InvalidPhoneNumber if number  == 'invalid_phone_number'
      BulkgateSmsGatewayContract::InvalidPhoneNumber if country == 'invalid_phone_number'
      BulkgateSmsGatewayContract::OutOfCredit if number  == 'low_credit'
      BulkgateSmsGatewayContract::EmptyMessageBody if body.blank?

      msg = "BULKGATE: #{body} TO: '#{country}:#{number}'"
      msg +=  " SENDER: #{sender_name}" if sender_name
      msg
    end
  end
end
