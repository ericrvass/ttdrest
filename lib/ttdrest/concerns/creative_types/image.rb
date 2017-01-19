module Ttdrest
  module Concerns
    module CreativeTypes
      module Image
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

          image_data = {
            "ImageContent" => image_content,
            "ClickthroughUrl" => clickthrough_url,
            "LandingPageUrl" => landing_page_url
          }

          if !params[:right_media_offer_type_id].nil?
            image_data = image_data.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
          end

          if !params[:ad_technology_ids].nil?
            image_data = image_data.merge({"AdTechnologyIds" => params[:ad_technology_ids]})
          end

          if !params[:is_securable].nil?
            image_data = image_data.merge({"IsSecurable" => params[:is_securable]})
          end

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

          image_data = {
            "ClickthroughUrl" => clickthrough_url,
            "LandingPageUrl" => landing_page_url
          }

          if !params[:right_media_offer_type_id].nil?
            image_data = image_data.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
          end
          if !params[:ad_technology_ids].nil?
            image_data = image_data.merge({"AdTechnologyIds" => params[:ad_technology_ids]})
          end
          if !params[:is_securable].nil?
            image_data = image_data.merge({"IsSecurable" => params[:is_securable]})
          end
          if !image_content.blank?
            image_data = image_data.merge({"ImageContent" => image_content})
          end

          creative_data = creative_data.merge({"ImageAttributes" => image_data})

          result = data_put(path, content_type, creative_data.to_json)
          return result
        end
      end
    end
  end
end
