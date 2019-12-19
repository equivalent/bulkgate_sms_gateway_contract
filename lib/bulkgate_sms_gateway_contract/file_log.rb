module BulkgateSmsGatewayContract
  module FileLog
    def self.send_sms(number:, country:, body:, sender_name: nil)
      raise BulkgateSmsGatewayContract::InvalidPhoneNumber, 'invalid_phone_number' if number  == 'invalid_phone_number'
      raise BulkgateSmsGatewayContract::InvalidPhoneNumber, 'invalid_phone_number' if country == 'invalid_phone_number'
      raise BulkgateSmsGatewayContract::OutOfCredit, 'low_credit' if number  == 'low_credit'
      raise BulkgateSmsGatewayContract::EmptyMessageBody, 'empty_message' if body.blank?

      msg = "BULKGATE: #{country}:#{number} - #{body}"
      msg += " | SENDER:#{sender_name}"
      _logger.info(msg)
    end

    def self._logger
      @_logger ||= Logger.new(Rails.root.join('log', 'sms.log'))
    end
  end
end
