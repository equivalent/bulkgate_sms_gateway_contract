module BulkgateSmsGatewayContract
  module FileLog
    def self.send_sms(number:, country:, body:, sender_name: nil)
      msg = "BULKGATE: #{country}:#{number} - #{body}"
      msg += " | SENDER:#{sender_name}"
      _logger.info(msg)
    end

    def self._logger
      @_logger ||= Logger.new(Rails.root.join('log', 'sms.log'))
    end
  end
end
