require 'bundler/setup'
require 'tessera'

require 'support/vcr'
require 'pry'
require 'rack/test'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  Tessera.configure do |c|
    c.username = 'tester'
    c.password = 'mysecretpassword'
    c.base_url = 'http://localhost/otrs/nph-genericinterface.pl/Webservice/tickets/'
  end
end
