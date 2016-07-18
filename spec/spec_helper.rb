require 'rubygems'
# Need active support for to_json and symbolize_keys!
require 'active_support/all'

# Require webmock and VCR to test requests
require 'webmock/rspec'
require 'vcr'

require 'rspec'
require 'ttdrest'

VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
end
