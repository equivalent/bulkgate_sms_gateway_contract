lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bulkgate_sms_gateway_contract/version"

Gem::Specification.new do |spec|
  spec.name          = "bulkgate_sms_gateway_contract"
  spec.version       = BulkgateSmsGatewayContract::VERSION
  spec.authors       = ["Tomas Valent"]
  spec.email         = ["equivalent@eq8.eu"]

  spec.summary       = %q{Contract classes for SMS Gateway provided by Bulkgate}
  spec.description   = %q{Contract classes for SMS Gateway (test + production for Bulkgate.com API)}
  spec.homepage      = "https://github.com/equivalent/bulkgate_sms_gateway_contract"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency 'rails', ">= 5.2" # needed for credentials

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
end
