module BulkgateSmsGatewayContract
  module FileLog
    def self.send_sms(number:, country:, body:, sender_name: nil)
      BulkgateSmsGatewayContract::FakeContractCommonalities
        .raise_when_invalid(country: country, body: body, number: number)

      msg = "BULKGATE: #{country}:#{number} - #{body}"
      msg += " | SENDER:#{sender_name}"
      _logger.info(msg)
    end

    def self._logger
      @_logger ||= Logger.new(Rails.root.join('log', 'sms.log'))
    end
  end
end
