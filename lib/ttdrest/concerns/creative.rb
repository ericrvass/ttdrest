module Ttdrest
  module Concerns
    module Creative

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

      def create_facebook_creative(name, image_content, clickthrough_url, landing_page_url, title, description, options = {})
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
          "LandingPageUrl" => landing_page_url,
          "FacebookTitle" => title,
          "FacebookBody" => description
        }

        if !params[:right_media_offer_type_id].nil?
          image_data = image_data.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
        end
        if !params[:ad_technology_ids].nil?
          image_data = image_data.merge({"AdTechnologyIds" => params[:ad_technology_ids]})
        end

        creative_data = creative_data.merge({"FacebookAttributes" => image_data})

        result = data_post(path, content_type, creative_data.to_json)
        return result
      end

      def update_facebook_creative(creative_id, name, image_content, clickthrough_url, landing_page_url, title, description, options = {})
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
          "LandingPageUrl" => landing_page_url,
          "FacebookTitle" => title,
          "FacebookBody" => description
        }

        if !params[:right_media_offer_type_id].nil?
          image_data = image_data.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
        end
        if !params[:ad_technology_ids].nil?
          image_data = image_data.merge({"AdTechnologyIds" => params[:ad_technology_ids]})
        end

        if !image_content.blank?
          image_data = image_data.merge({"ImageContent" => image_content})
        end

        creative_data = creative_data.merge({"FacebookAttributes" => image_data})

        result = data_put(path, content_type, creative_data.to_json)
        return result
      end

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

        creative_data = creative_data.merge({"FlashAttributes" => flash_data})
        result = data_post(path, content_type, creative_data.to_json)
        return result
      end

      #TODO: 3rd Party HTML Creatives

      def create_video_creative(name, video_content, clickthrough_url, landing_page_url, options = {})
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

        video_data = {
          "VideoContent" => video_content,
          "ClickthroughUrl" => clickthrough_url,
          "LandingPageUrl" => landing_page_url
        }

        if !params[:right_media_offer_type_id].nil?
          video_data = video_data.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
        end
        if !params[:ad_technology_ids].nil?
          video_data = video_data.merge({"AdTechnologyIds" => params[:ad_technology_ids]})
        end
        if !params[:is_securable].nil?
          video_data = video_data.merge({"IsSecurable" => params[:is_securable]})
        end

        creative_data = creative_data.merge({"TradeDeskHostedVideoAttributes" => video_data})

        result = data_post(path, content_type, creative_data.to_json)
        return result
      end

    end
  end
end
