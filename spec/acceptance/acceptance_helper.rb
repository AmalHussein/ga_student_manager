require 'spec_helper'
require 'email_spec'
require 'capybara/poltergeist'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/acceptance/cassettes'
  c.hook_into :fakeweb
  c.ignore_localhost = true
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

Capybara.javascript_driver = :poltergeist
Capybara.ignore_hidden_elements = true
Capybara.server_port = 7787
 
# Put your acceptance spec helpers inside spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}