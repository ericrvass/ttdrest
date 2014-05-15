require "ttdrest/concerns/base"
require "ttdrest/concerns/ad_group"
require "ttdrest/concerns/audience"
require "ttdrest/concerns/campaign"
require "ttdrest/concerns/creative"
require "ttdrest/concerns/data_group"
require "ttdrest/concerns/dmp"
require "ttdrest/concerns/tracking_tags"

module Ttdrest
  # Interface for using the TTD REST API
  class Client
    include Ttdrest::Concerns::Base
    include Ttdrest::Concerns::AdGroup
    include Ttdrest::Concerns::Audience
    include Ttdrest::Concerns::Campaign
    include Ttdrest::Concerns::Creative
    include Ttdrest::Concerns::DataGroup
    include Ttdrest::Concerns::Dmp
    include Ttdrest::Concerns::TrackingTags
    
    # The Auth client login
    attr_accessor :client_login
    # The Auth client password
    attr_accessor :client_password
    # The Auth access token
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