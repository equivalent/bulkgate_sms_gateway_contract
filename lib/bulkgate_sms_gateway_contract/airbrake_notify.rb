module BulkgateSmsGatewayContract
  module AirbrakeNotify
    def self.send_sms(number:, country:, body:, sender_name: nil)
      raise BulkgateSmsGatewayContract::InvalidPhoneNumber, 'invalid_phone_number' if number  == 'invalid_phone_number'
      raise BulkgateSmsGatewayContract::InvalidPhoneNumber, 'invalid_phone_number' if country == 'invalid_phone_number'
      raise BulkgateSmsGatewayContract::OutOfCredit, 'low_credit' if number  == 'low_credit'
      raise BulkgateSmsGatewayContract::EmptyMessageBody, 'empty_message' if body.blank?

      msg = "BulkgateSmsGatewayContract: login_code #{code} for #{country} #{number}"
      msg += " | SENDER #{sender_name}" if sender_name
      Airbrake.notify(msg)
    end
  end
end
