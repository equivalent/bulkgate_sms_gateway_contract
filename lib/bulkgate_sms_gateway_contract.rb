require 'json'
require 'rails'
require 'httparty'
require "bulkgate_sms_gateway_contract/version"
require "bulkgate_sms_gateway_contract/fake_contract_commonalities"
require "bulkgate_sms_gateway_contract/real"
require "bulkgate_sms_gateway_contract/mock"
require "bulkgate_sms_gateway_contract/file_log"

module BulkgateSmsGatewayContract
  BulkgateError = Class.new(StandardError)

  InvalidApplicationIdOrApplicationToken = Class.new(BulkgateError)
  InvalidPhoneNumber = Class.new(BulkgateError)
  EmptyMessageBody = Class.new(BulkgateError)
  OutOfCredit = Class.new(BulkgateError)

  def self.contract
    Rails.application.config.x.bulkgate_sms_gateway_contract.constantize
  end
end
