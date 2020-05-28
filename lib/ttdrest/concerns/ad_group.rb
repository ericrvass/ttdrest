module Ttdrest
  module Concerns
    module AdGroup

      def get_ad_groups(campaign_id, options = {})
        path = "adgroup/query/campaign"
        params = { CampaignId: campaign_id, PageStartIndex: 0, PageSize: nil }
        content_type = 'application/json'
        data_post(path, content_type, params.to_json)
      end

      def get_ad_group(ad_group_id, options = {})
        get("/adgroup/#{ad_group_id}", {})
      end

      def create_ad_group(campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids = [], options = {})
        path = "/adgroup"
        content_type = 'application/json'
        params = options[:params] || {}

        # Build main ad group data hash
        ad_group_data = build_ad_group_data(nil, campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids, params)

        result = data_post(path, content_type, ad_group_data.to_json)
        return result
      end

      def update_ad_group(ad_group_id, campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids = [], options = {})
        path = "/adgroup"
        content_type = 'application/json'
        params = options[:params] || {}

        # Build main ad group data hash
        ad_group_data = build_ad_group_data(ad_group_id, campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids, params)

        result = data_put(path, content_type, ad_group_data.to_json)
        return result
      end

      def build_ad_group_data(ad_group_id, campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids = [], params = {})
        if params[:is_classic].nil? || params[:is_classic]
          build_classic_ad_group_data(ad_group_id, campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids, params)
        else
          build_megagon_ad_group_data(ad_group_id, campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids, params)
        end
      end

      def build_classic_ad_group_data(ad_group_id, campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids, params) 
        # Build main ad group data hash
        ad_group_data = {}
        if !ad_group_id.nil?
          ad_group_data = ad_group_data.merge({"AdGroupId" => ad_group_id})
        end
        if !campaign_id.nil?
          ad_group_data = ad_group_data.merge({"CampaignId" => campaign_id})
        end
        if !name.nil?
          ad_group_data = ad_group_data.merge({"AdGroupName" => name})
        end

        ad_group_data['IsClassic'] = true 

        if !params[:description].nil?
          ad_group_data = ad_group_data.merge({"Description" => params[:description]})
        end
        if !params[:is_enabled].nil?
          ad_group_data = ad_group_data.merge({"IsEnabled" => params[:is_enabled]})
        end
        if !params[:industry_category_id].nil?
          ad_group_data = ad_group_data.merge({"IndustryCategoryId" => params[:industry_category_id]})
        end

        # Build RTB ad group data hash
        rtb_ad_group_data = {}
        if !budget_settings.nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"BudgetSettings" => budget_settings})
        end
        if !base_bid_cpm.nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"BaseBidCPM" => base_bid_cpm})
        end
        if !max_bid_cpm.nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"MaxBidCPM" => max_bid_cpm})
        end
        if !creative_ids.empty?
          rtb_ad_group_data = rtb_ad_group_data.merge({"CreativeIds" => creative_ids})
        end
        if !params[:frequency_settings].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"FrequencySettings" => params[:frequency_settings]})
        end
        if !params[:site_targeting].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"SiteTargeting" => params[:site_targeting]})
        end
        if !params[:fold_targeting].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"FoldTargeting" => params[:fold_targeting]})
        end
        if !params[:supply_vendors].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"SupplyVendorAdjustments" => params[:supply_vendors]})
        end
        if !params[:contract_targeting].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"ContractTargeting" => params[:contract_targeting]})
        end
        if !params[:site_quality_settings].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"SiteQualitySettings" => params[:site_quality_settings]})
        end
        if !params[:audience_id].nil?
          # Build audience data hash
          audience_data = { "AudienceId" => params[:audience_id] }
          if !params[:recency_adjustments].blank?
            audience_data = audience_data.merge({"RecencyAdjustments" => params[:recency_adjustments]})
          else
            audience_data = audience_data.merge({"RecencyAdjustments" => [{"RecencyWindowStartInMinutes" => 0, "Adjustment" => 1.0}]})
          end
          if !params[:regency_exclusion_window_in_minutes].blank?
            audience_data = audience_data.merge({"RecencyExclusionWindowInMinutes" => params[:regency_exclusion_window_in_minutes]})
          else
            audience_data = audience_data.merge({"RecencyExclusionWindowInMinutes" => 129600}) #default to 129600 (90 days)
          end
          rtb_ad_group_data = rtb_ad_group_data.merge({"AudienceTargeting" => audience_data})
        end
        if !params[:geo_segment_adjustments].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"GeoSegmentAdjustments" => params[:geo_segment_adjustments]})
        end
        if !params[:data_element_adjustments].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"DataElementAdjustments" => params[:data_element_adjustments]})
        end
        #TODO: AdFormatAdjustments
        #TODO: UserHourOfWeekAdjustments
        #TODO: SupplyVendorAdjustments
        #TODO: BrowserAdjustments
        #TODO: OSAdjustments
        #TODO: OSFamilyAdjustments
        #TODO: DeviceTypeAdjustments

        if !rtb_ad_group_data.empty?
          ad_group_data = ad_group_data.merge({"RTBAttributes" => rtb_ad_group_data})
        end

        return ad_group_data
      end

      def build_megagon_ad_group_data(ad_group_id, campaign_id, name, budget_settings, base_bid_cpm, max_bid_cpm, creative_ids, params) 
        {}.tap do |ad_group_data|
          ad_group_data["AdGroupId"] = ad_group_id unless ad_group_id.nil?
          ad_group_data["CampaignId"] = campaign_id unless campaign_id.nil?
          ad_group_data["AdGroupName"] = name unless name.nil?
          ad_group_data["Description"] = params[:description] unless params[:description].nil?
          ad_group_data["IsEnabled"] = params[:is_enabled] unless params[:is_enabled].nil?
          ad_group_data["IndustryCategoryId"] = params[:industry_category_id] unless params[:industry_category_id].nil? 
          ad_group_data['IsClassic'] = false

          ad_group_data['AssociatedBidLists'] = params[:associated_bid_lists] unless params[:associated_bid_lists].nil?

          {}.tap do |rtb_ad_group_data|
            rtb_ad_group_data["BudgetSettings"] = budget_settings unless budget_settings.nil?
            rtb_ad_group_data["BaseBidCPM"] = base_bid_cpm unless base_bid_cpm.nil?
            rtb_ad_group_data["MaxBidCPM"] = max_bid_cpm unless max_bid_cpm.nil?
            rtb_ad_group_data["CreativeIds"] = creative_ids unless creative_ids.empty?

            unless params[:audience_id].nil?
              {}.tap do |audience_data|
                audience_data["AudienceId"] = params[:audience_id]

                if !params[:regency_exclusion_window_in_minutes].blank?
                  audience_data["RecencyExclusionWindowInMinutes"] = params[:regency_exclusion_window_in_minutes]
                else
                  audience_data["RecencyExclusionWindowInMinutes"] = 129600 #default to 129600 (90 days)
                end

                rtb_ad_group_data["AudienceTargeting"] = audience_data
              end
            end

            ad_group_data['RTBAttributes'] = rtb_ad_group_data unless rtb_ad_group_data.empty?
          end
        end
      end
    end
  end
end
