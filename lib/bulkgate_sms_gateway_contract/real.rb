module BulkgateSmsGatewayContract
  module Real
    # based on https://help.bulkgate.com/docs/en/http-simple-transactional.html#sender-id-type-sender_id
    def self.send_sms(number:, country:, body:, sender_name: nil)
      body = {
        "application_id": Rails.application.credentials.dig(:bulkgate_sms, :application_id),
        "application_token": Rails.application.credentials.dig(:bulkgate_sms, :application_token),
        "number": number,
        "text": body,
        "country": country,
      }

      if sender_name # eg 'mycompany.com'
        body.merge!({
          'sender_id' => 'gText',
          'sender_id_value' => sender_name
        })
      end

      resp = HTTParty.post('https://portal.bulkgate.com/api/1.0/simple/transactional', body: body)
      case resp.code
      when 401
        raise BulkgateSmsGatewayContract::InvalidApplicationIdOrApplicationToken
      when 400
        resp_body_hash = JSON.parse(resp.body)
        error_type = resp_body_hash['type'] 
        case error_type
        when 'invalid_phone_number'
          raise BulkgateSmsGatewayContract::InvalidPhoneNumber
        when 'empty_message'
          raise BulkgateSmsGatewayContract::EmptyMessageBody
        when 'low_credit'
          raise BulkgateSmsGatewayContract::OutOfCredit
        else
          # for more deatils see https://help.bulkgate.com/docs/en/api-error-types.html#error-types
          raise BulkgateSmsGatewayContract::BulkgateError, error_type
        end
      when 200
        resp_body_hash
      end
    end
  end
end
