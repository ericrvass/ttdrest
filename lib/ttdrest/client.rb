require "ttdrest/concerns/base"
require "ttdrest/concerns/campaign"

module Ttdrest
  # Interface for using the TTD REST API
  class Client
    include Ttdrest::Concerns::Base
    include Ttdrest::Concerns::Campaign
    
    # The OAuth client login
    attr_accessor :client_login
    # The OAuth client password
    attr_accessor :client_password
    # The OAuth access token
    attr_accessor :auth_token
    # The Host
    attr_accessor :host
    # The Advertiser ID
    attr_accessor :advertiser_id
    
    def initialize(options = {})
      if options.is_a?(String)
        @options = YAML.load_file(options)
      else
        @options = options
      end
      @options.symbolize_keys!
      
      self.client_login = ENV['TTD_CLIENT_LOGIN'] || @options[:client_login]
      self.client_password = ENV['TTD_CLIENT_PASSWORD'] || @options[:client_password]
      self.host = ENV['TTD_HOST'] || @options[:host]
      self.advertiser_id = ENV['TTD_ADVERTISER_ID'] || @options[:advertiser_id]
    end
    
  end
end