module Ttdrest
  module Concerns
    module Creative

      def get_creatives(options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/creatives/#{advertiser_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def get_creative(creative_id, options = {})
        path = "/creative/#{creative_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def create_image_creative(name, image_content, clickthrough_url, landing_page_url, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/creative"
        content_type = 'application/json'
        creative_data = {
          "AdvertiserId" => advertiser_id,
          "CreativeName" => name
          }
        params = options[:params] || {}
        if !params[:description].nil?
          creative_data = creative_data.merge({"Description" => params[:description]})
        end
        if !params[:third_party_impression_tracking_url].nil?
          creative_data = creative_data.merge({"ThirdPartyImpressionTrackingUrl" => params[:third_party_impression_tracking_url]})
        end
        if !params[:right_media_offer_type_id].nil?
          creative_data = creative_data.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
        end
        if !params[:ad_technology_ids].nil?
          creative_data = creative_data.merge({"AdTechnologyIds" => params[:ad_technology_ids]})
        end
        
        image_data = {
          "ImageContent" => image_content,
          "ClickthroughUrl" => clickthrough_url,
          "LandingPageUrl" => landing_page_url
          }
        
        creative_data = creative_data.merge({"ImageAttributes" => image_data})
        
        result = data_post(path, content_type, creative_data.to_json)
        return result
      end

      def update_image_creative(creative_id, name, image_content, clickthrough_url, landing_page_url, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/creative"
        content_type = 'application/json'
        creative_data = {
          "CreativeId" => creative_id,
          "AdvertiserId" => advertiser_id,
          "CreativeName" => name
          }
        params = options[:params] || {}
        if !params[:description].nil?
          creative_data = creative_data.merge({"Description" => params[:description]})
        end
        if !params[:third_party_impression_tracking_url].nil?
          creative_data = creative_data.merge({"ThirdPartyImpressionTrackingUrl" => params[:third_party_impression_tracking_url]})
        end
        if !params[:right_media_offer_type_id].nil?
          creative_data = creative_data.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
        end
        if !params[:ad_technology_ids].nil?
          creative_data = creative_data.merge({"AdTechnologyIds" => params[:ad_technology_ids]})
        end
        
        image_data = {
          "ClickthroughUrl" => clickthrough_url,
          "LandingPageUrl" => landing_page_url
          }

        if !image_data.blank?
          image_data = image_data.merge({"ImageContent" => image_content]})
        end
        
        creative_data = creative_data.merge({"ImageAttributes" => image_data})
        
        result = data_put(path, content_type, creative_data.to_json)
        return result
      end
      
      #TODO: Facebook Creatives
      
      #TODO: Flash Creatives
      
      #TODO: 3rd Party HTML Creatives
      
      #TODO: Video Creatives
      
    end
  end
end