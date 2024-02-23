module Ttdrest
  module Concerns
    module Advertiser

      def get_advertisers(partner_id, options = {})
        path = "/advertiser/query/partner"
        params = { PartnerId: partner_id, PageStartIndex: 0, PageSize: nil }
        content_type = 'application/json'
        result = data_post(path, content_type, params.to_json)
        return result
      end
      
      def get_advertiser(advertiser_id, options = {})
        path = "/advertiser/#{advertiser_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def update_advertiser(advertiser_id, name, options = {})
        path = "/advertiser"
        content_type = 'application/json'
        params = options[:params] || {}
        
        # Build advertiser data hash
        advertiser_data = build_advertiser_data(nil, advertiser_id, name, params)

        result = data_put(path, content_type, advertiser_data.to_json)
        return result
      end
      
      def create_advertiser(partner_id, name, options = {})
        path = "/advertiser"
        content_type = 'application/json'
        params = options[:params] || {}
        advertiser_data = build_advertiser_data(partner_id, nil, name, params)
        result = data_post(path, content_type, advertiser_data.to_json)
        return result
      end
      
      def build_advertiser_data(partner_id, advertiser_id, name, params = {})
        advertiser_data = {}
        if !partner_id.nil?
          advertiser_data = advertiser_data.merge({"PartnerId" => partner_id})
        end
        if !advertiser_id.nil?
          advertiser_data = advertiser_data.merge({"AdvertiserId" => advertiser_id})
        end
        if !name.blank?
          advertiser_data = advertiser_data.merge({"AdvertiserName" => name})
        end
        if !params[:description].nil?
          advertiser_data = advertiser_data.merge({"Description" => params[:description]})
        end
        if !params[:domain_address].blank?
          advertiser_data["DomainAddress"] = params[:domain_address]
        end
        if !params[:currency_code].nil?
          advertiser_data = advertiser_data.merge({"CurrencyCode" => params[:currency_code]})
        end
        if !params[:attribution_click_lookback_window_in_seconds].nil?
          advertiser_data = advertiser_data.merge({"AttributionClickLookbackWindowInSeconds" => params[:attribution_click_lookback_window_in_seconds]})
        end
        if !params[:attribution_impression_lookback_window_in_seconds].nil?
          advertiser_data = advertiser_data.merge({"AttributionImpressionLookbackWindowInSeconds" => params[:attribution_impression_lookback_window_in_seconds]})
        end
        if !params[:click_dedup_window_in_seconds].nil?
          advertiser_data = advertiser_data.merge({"ClickDedupWindowInSeconds" => params[:click_dedup_window_in_seconds]})
        end
        if !params[:conversion_dedup_window_in_seconds].nil?
          advertiser_data = advertiser_data.merge({"ConversionDedupWindowInSeconds" => params[:conversion_dedup_window_in_seconds]})
        end
        if !params[:default_right_media_offer_type_id].nil?
          advertiser_data = advertiser_data.merge({"DefaultRightMediaOfferTypeId" => params[:default_right_media_offer_type_id]})
        end
        if !params[:facebook_attributes].nil?
          advertiser_data = advertiser_data.merge({"FacebookAttributes" => params[:facebook_attributes]})
        end
        if !params[:keywords].nil?
          advertiser_data = advertiser_data.merge({"Keywords" => params[:keywords]})
        end
        if !params[:industry_category_id].nil?
          advertiser_data = advertiser_data.merge({"IndustryCategoryId" => params[:industry_category_id]})
        end
        if !params[:advertiser_name_dsa].nil?
          advertiser_data = advertiser_data.merge({"AdvertiserNameDsa" => params[:advertiser_name_dsa]})
        end
        if !params[:payer_name_dsa].nil?
          advertiser_data = advertiser_data.merge({"PayerNameDsa" => params[:payer_name_dsa]})
        end
        return advertiser_data
      end
      
    end
  end
end
