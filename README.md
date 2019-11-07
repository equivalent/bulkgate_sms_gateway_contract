# SmsGatewayContract

The following gem is a Gateway Test contract  & Production gateway for
sending SMS texts via service API:  https://www.bulkgate.com/

Gem is designed for Rails only.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'sms_gateway_contract'
```

And then execute:

    $ bundle

## Usage

Configure environment

and Then just call `SmsGatewayContract.contract.send_sms(number: 908123123, country: 'sk', body: 'whatever'`


#### Real

This is the real thing that is seding SMS via  Bulkgate.com API

```ruby
#config/environments/production.rb

Rails.application.configure do
  # ...
  config.x.sms_gateway = 'SmsGatewayContract::Real'
  # ...
end
```

you also need to configure [Rails credentials](https://blog.eq8.eu/til/rails-52-credentials-tricks.html)

```
bulkgate_sms:
  application_id: yyyy
  application_token: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

#### Test

This is actuall Test contract

If you don't know what Test contracts are please read:
https://blog.eq8.eu/article/explicit-contracts-for-rails-http-api-usecase.html


```ruby
#config/environments/test.rb

Rails.application.configure do
  # ...
  config.x.sms_gateway = 'SmsGatewayContract::Mock'
  # ...
end
```

Example RSpec usage:

```ruby
require 'rails_helper'
RSpec.describe 'sending of SMS' do
  def trigger
    SmsGatewayContract.contract.send_sms(
      country: "sk",
      number: 908111222,
      body: "Your 2FA code is 1234")
   end

  it do
    expect(trigger).to eq "Your 2FA code is 1234 TO: sk:908111222"
  end
end
```

#### File

Will log SMS codes to `log/sms.log`

```ruby
#config/environments/development.rb

Rails.application.configure do
  # ...
  config.x.sms_gateway = 'SmsGatewayContract::File'
  # ...
end
```


## Code of Conduct

Everyone interacting in the SmsGatewayContract project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/equivalent/sms_gateway_contract/blob/master/CODE_OF_CONDUCT.md).
