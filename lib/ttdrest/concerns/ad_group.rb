module Ttdrest
  module Concerns
    module AdGroup

      def get_ad_groups(campaign_id, options = {})
        path = "/adgroups/#{campaign_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def get_ad_group(ad_group_id, options = {})
        path = "/adgroup/#{ad_group_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def create_ad_group(campaign_id, name, budget_in_dollars, daily_budget_in_dollars, pacing_enabled, base_bid_cpm_in_dollars, max_bid_cpm_in_dollars, creative_ids = [], options = {})
        path = "/adgroup"
        content_type = 'application/json'
        params = options[:params] || {}
        
        # Build main ad group data hash
        ad_group_data = build_ad_group_data(nil, campaign_id, name, budget_in_dollars, daily_budget_in_dollars, pacing_enabled, base_bid_cpm_in_dollars, max_bid_cpm_in_dollars, creative_ids, params)
        
        result = data_post(path, content_type, ad_group_data.to_json)
        return result
      end
      
      def update_ad_group(ad_group_id, campaign_id, name, budget_in_dollars, daily_budget_in_dollars, pacing_enabled, base_bid_cpm_in_dollars, max_bid_cpm_in_dollars, creative_ids = [], options = {})
        path = "/adgroup"
        content_type = 'application/json'
        params = options[:params] || {}
        
        # Build main ad group data hash
        ad_group_data = build_ad_group_data(ad_group_id, campaign_id, name, budget_in_dollars, daily_budget_in_dollars, pacing_enabled, base_bid_cpm_in_dollars, max_bid_cpm_in_dollars, creative_ids, params)
        
        result = data_put(path, content_type, ad_group_data.to_json)
        return result
      end
      
      def build_ad_group_data(ad_group_id, campaign_id, name, budget_in_dollars, daily_budget_in_dollars, pacing_enabled, base_bid_cpm_in_dollars, max_bid_cpm_in_dollars, creative_ids = [], params = {})
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
        if !budget_in_dollars.nil?
          ad_group_data = ad_group_data.merge({"BudgetInUSDollars" => budget_in_dollars})
        end
        if !daily_budget_in_dollars.nil?
          ad_group_data = ad_group_data.merge({"DailyBudgetInUSDollars" => daily_budget_in_dollars})
        end
        if !pacing_enabled.nil?
          ad_group_data = ad_group_data.merge({"PacingEnabled" => pacing_enabled})
        end
        if !base_bid_cpm_in_dollars.nil?
          ad_group_data = ad_group_data.merge({"BaseBidCPMInUSDollars" => base_bid_cpm_in_dollars})
        end
        if !max_bid_cpm_in_dollars.nil?
          ad_group_data = ad_group_data.merge({"MaxBidCPMInUSDollars" => max_bid_cpm_in_dollars})
        end
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
        if !budget_in_dollars.nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"BudgetInUSDollars" => budget_in_dollars})
        end
        if !daily_budget_in_dollars.nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"DailyBudgetInUSDollars" => daily_budget_in_dollars})
        end
        if !pacing_enabled.nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"PacingEnabled" => pacing_enabled})
        end
        if !base_bid_cpm_in_dollars.nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"BaseBidCPMInUSDollars" => base_bid_cpm_in_dollars})
        end
        if !max_bid_cpm_in_dollars.nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"MaxBidCPMInUSDollars" => max_bid_cpm_in_dollars})
        end
        if !creative_ids.empty? 
          rtb_ad_group_data = rtb_ad_group_data.merge({"CreativeIds" => creative_ids})
        end
        if !params[:frequency_pricing_slope].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"FrequencyPricingSlope" => params[:frequency_pricing_slope]})
        end
        if !params[:frequency_period_in_minutes].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"FrequencyPeriodInMinutes" => params[:frequency_period_in_minutes]})
        end
        if !params[:frequency_cap].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"FrequencyCap" => params[:frequency_cap]})
        end
        if !params[:site_list_ids].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"SiteListIds" => params[:site_list_ids]})
        end
        if !params[:site_list_fall_through_adjustment].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"SiteListFallThroughAdjustment" => params[:site_list_fall_through_adjustment]})
        end
        if !params[:above_fold_adjustment].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"AboveFoldAdjustment" => params[:above_fold_adjustment]})
        end
        if !params[:below_fold_adjustment].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"BelowFoldAdjustment" => params[:below_fold_adjustment]})
        end
        if !params[:unknown_fold_adjustment].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"UnknownFoldAdjustment" => params[:unknown_fold_adjustment]})
        end
        if !params[:budget_in_impressions].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"BudgetInImpressions" => params[:budget_in_impressions]})
        end
        if !params[:daily_budget_in_impressions].nil?
          rtb_ad_group_data = rtb_ad_group_data.merge({"DailyBudgetInImpressions" => params[:daily_budget_in_impressions]})
        end
        if !params[:audience_id].nil?
          # Build audience data hash
          audience_data = {
            "AudienceId" => params[:audience_id]
            }
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
        else
          rtb_ad_group_data = rtb_ad_group_data.merge({"GeoSegmentAdjustments" => [{"Id" => "hjapafa", "Adjustment" => 1.0}]}) # defaults to USA
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
      
    end
  end
end
