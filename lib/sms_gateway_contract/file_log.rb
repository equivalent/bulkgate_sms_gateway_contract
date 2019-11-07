module SmsGatewayContract
  module FileLog
    def self.send_sms(number:, country:, body:)
      _logger.info("#{country}:#{number} - #{body}")
    end

    def self._logger
      @_logger ||= Logger.new(Rails.root.join('log', 'sms.log'))
    end
  end
end
