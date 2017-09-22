module Ttdrest
  module Concerns
    module CreativeTypes
      module Flash
        def create_flash_creative(name, flash_content, clickthrough_url, landing_page_url, options = {})
          advertiser_id = self.advertiser_id || options[:advertiser_id]
          path = "/creative"
          content_type = 'application/json'
          creative_data = {
            "AdvertiserId" => advertiser_id,
            "CreativeName" => name
          }
          params = options[:params] || {}

          flash_data = {
            "FlashContent" => flash_content,
            "ClickthroughUrl" => clickthrough_url,
            "LandingPageUrl" => landing_page_url,
            "FlashClickTrackingParameterName" => params[:click_tag].nil? ? "clickTAG" : params[:click_tag]
          }

          if !params[:right_media_offer_type_id].nil?
            flash_data = flash_data.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
          end
          if !params[:is_securable].nil?
            flash_data = flash_data.merge({"IsSecurable" => params[:is_securable]})
          end

          if !params[:third_party_tracking_tags].nil?
            flash_data = flash_data.merge({
              ThirdPartyTrackingTags: [ params[:third_party_tracking_tags] ]
            })
          end

          creative_data = creative_data.merge({"FlashAttributes" => flash_data})
          result = data_post(path, content_type, creative_data.to_json)
          return result
        end
      end
    end
  end
end
