# BulkgateSmsGatewayContract

The following gem is a Gateway Test contract  & Production gateway for
sending SMS texts via service API:  https://www.bulkgate.com/

Gem is designed for Rails only.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'bulkgate_sms_gateway_contract'
```

And then execute:

    $ bundle

## Usage

step 1: Configure Rails environments (individual sections down bellow)

step 2: Then just call:

```ruby
BulkgateSmsGatewayContract.contract.send_sms(country: 'sk', number: 908123123, body: 'whatever')
# or
BulkgateSmsGatewayContract.contract.send_sms(country: 'sk', number: 908123123, body: 'whatever', sender_name: "my-website.com")
```

#### Production

This is the real thing that will send SMS via  Bulkgate.com API

```ruby
#config/environments/production.rb

Rails.application.configure do
  # ...
  config.x.bulkgate_sms_gateway_contract = 'BulkgateSmsGatewayContract::Real'
  # ...
end
```

you also need to configure [Rails credentials](https://blog.eq8.eu/til/rails-52-credentials-tricks.html)

```
# ...
bulkgate_sms:
  application_id: yyyy
  application_token: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
# ...
```

> in order to open Rails credentials you can do `EDITOR=vim bundle exec rails credentials:edit`

In case of API error exception `BulkgateError` with Bulkgate error type as message.

You can capture exception as

```ruby
begin
  BulkgateSmsGatewayContract.contract.send_sms(country: 'sk', number: 'this-is-wrong', body: '666666 is your Authentication code')
rescue BulkgateSmsGatewayContract::BulkgateError => e
  puts "rescue any API specific error form Bulkgate"
end

# or

begin
  BulkgateSmsGatewayContract.contract.send_sms(country: 'sk', number: 'this-is-wrong', body: '666666 is your Authentication code')
rescue BulkgateSmsGatewayContract::BulkgateError, 'invalid_phone_number'
  puts "phone number invalid"
end

# or gem also provides custom error classes for most common errors like

rescue BulkgateSmsGatewayContract::EmptyMessageBody
rescue BulkgateSmsGatewayContract::InvalidPhoneNumber
rescue BulkgateSmsGatewayContract::OutOfCredit
```

> see https://help.bulkgate.com/docs/en/api-error-types.html#error-types for full list off error types

#### Test

This is actuall Test contract

If you don't know what Test contracts are please read:
https://blog.eq8.eu/article/explicit-contracts-for-rails-http-api-usecase.html


```ruby
#config/environments/test.rb

Rails.application.configure do
  # ...
  config.x.bulkgate_sms_gateway_contract = 'BulkgateSmsGatewayContract::Mock'
  # ...
end
```

Example RSpec usage:

```ruby
require 'rails_helper'
RSpec.describe 'sending of SMS' do
  def trigger
    BulkgateSmsGatewayContract.contract.send_sms(
      country: "sk",
      number: 908111222,
      body: "Your 2FA code is 1234")
   end

  it do
    expect(trigger).to eq "Bulkgate: Your 2FA code is 1234 TO: sk:908111222"
  end
end
```

#### Development

Will log SMS codes to `log/sms.log`

```ruby
#config/environments/development.rb

Rails.application.configure do
  # ...
  config.x.bulkgate_sms_gateway_contract = 'BulkgateSmsGatewayContract::FileLog'
  # ...
end
```

### Bonus - Production with Airbrake Debugging

If you are using [Airbrake](https://github.com/airbrake/airbrake) you
can use for production debugging `AirbrakeNotify` contract

```ruby
# config/environments/production.rb

# This contract is not loaded by default. You need to explicitly require it
require 'sms_gateway_contract/airbrake_notify'

# ...
  config.x.bulkgate_sms_gateway_contract = 'BulkgateSmsGatewayContract::AirbrakeNotify'
# ...
```

> `BulkgateSmsGatewayContract::AirbrakeNotify` is only for debugging production. It's more a lazy tool to save cost during develompment. Don't use it once live.


## Code of Conduct

Everyone interacting in the SmsGatewayContract project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/equivalent/bulkgate_sms_gateway_contract/blob/master/CODE_OF_CONDUCT.md).
