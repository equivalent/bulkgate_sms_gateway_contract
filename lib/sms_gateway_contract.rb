require "sms_gateway_contract/version"

module SmsGatewayContract
  def self.contract
    Rails.application.config.x.sms_gateway.constantize
  end
end
