module SmsGatewayContract
  module Real
    def self.send_sms(number:, country:, body:)
      HTTParty.post('https://portal.bulkgate.com/api/1.0/simple/transactional', body: {
        "application_id": Rails.application.credentials.dig(:bulkgate_sms, :application_id),
        "application_token": Rails.application.credentials.dig(:bulkgate_sms, :application_token),
        "number": number,
        "text": body,
        "country": country
      })
    end
  end
end
