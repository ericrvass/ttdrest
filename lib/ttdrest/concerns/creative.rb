Dir["lib/ttdrest/concerns/creative_types/*.rb"].each { |f| require f.gsub('lib/', '') }

module Ttdrest
  module Concerns
    module Creative
      include Ttdrest::Concerns::CreativeTypes::Facebook
      include Ttdrest::Concerns::CreativeTypes::Flash
      include Ttdrest::Concerns::CreativeTypes::Image
      include Ttdrest::Concerns::CreativeTypes::Video

      def get_creatives(options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/creative/query/advertiser"
        params = { AdvertiserId: advertiser_id, PageStartIndex: 0, PageSize: nil }
        content_type = 'application/json'
        data_post(path, content_type, params.to_json)
      end

      def get_creative(creative_id, options = {})
        path = "/creative/#{creative_id}"
        params = {}
        result = get(path, params)
        return result
      end

      #TODO: 3rd Party HTML Creatives

    end
  end
end
