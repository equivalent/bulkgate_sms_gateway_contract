module BulkgateSmsGatewayContract
  module FakeContractCommonalities
    def self.raise_when_invalid(country:, body:, number:)
      raise BulkgateSmsGatewayContract::InvalidPhoneNumber, 'invalid_phone_number' if number  == 'invalid_phone_number'
      raise BulkgateSmsGatewayContract::InvalidPhoneNumber, 'invalid_phone_number' if country == 'invalid_phone_number'
      raise BulkgateSmsGatewayContract::OutOfCredit, 'low_credit' if number  == 'low_credit'
      raise BulkgateSmsGatewayContract::EmptyMessageBody, 'empty_message' if body.blank?
    end
  end
end
