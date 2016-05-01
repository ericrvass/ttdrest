module Ttdrest
  module Concerns
    module Campaign

      def get_campaigns(options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/campaign/query/advertiser"
        params = { AdvertiserId: advertiser_id, PageStartIndex: 0, PageSize: nil }
        content_type = 'application/json'
        result = data_post(path, content_type, params.to_json)
        return result
      end
      
      def get_campaign(campaign_id, options = {})
        path = "/campaign/#{campaign_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def update_campaign(campaign_id, name, budget, start_date, campaign_conversion_reporting_columns = [], options = {})
        path = "/campaign"
        content_type = 'application/json'
        params = options[:params] || {}
        
        # Build campaign data hash
        campaign_data = build_campaign_data(campaign_id, name, budget, start_date, campaign_conversion_reporting_columns, params)

        result = data_put(path, content_type, campaign_data.to_json)
        return result
      end
      
      def create_campaign(name, budget, start_date, campaign_conversion_reporting_columns = [], options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/campaign"
        content_type = 'application/json'
        params = options[:params] || {}
        campaign_data = build_campaign_data(nil, name, budget, start_date, campaign_conversion_reporting_columns, params)
        result = data_post(path, content_type, campaign_data.to_json)
        return result
      end
      
      def build_campaign_data(campaign_id, name, budget, start_date, campaign_conversion_reporting_columns = [], params = {})
        campaign_data = {
          "AdvertiserId" => advertiser_id,
          "CampaignConversionReportingColumns" => campaign_conversion_reporting_columns
          }
        if !campaign_id.nil?
          campaign_data = campaign_data.merge({"CampaignId" => campaign_id})
        end
        if !name.blank?
          campaign_data = campaign_data.merge({"CampaignName" => name})
        end
        if !budget.nil?
          campaign_data = campaign_data.merge({"Budget" => budget})
        end
        if !start_date.nil?
          campaign_data = campaign_data.merge({"StartDate" => start_date.strftime("%Y-%m-%dT%H:%M:%SZ")})
        end
        if !params[:description].nil?
          campaign_data = campaign_data.merge({"Description" => params[:description]})
        end
        if !params[:budget_in_impressions].nil?
          campaign_data = campaign_data.merge({"BudgetInImpressions" => params[:budget_in_impressions]})
        end
        if !params[:daily_budget].nil?
          campaign_data = campaign_data.merge({"DailyBudget" => params[:daily_budget]})
        end
        if !params[:daily_budget_in_impressions].nil?
          campaign_data = campaign_data.merge({"DailyBudgetInImpressions" => params[:daily_budget_in_impressions]})
        end
        if !params[:end_date].nil?
          campaign_data = campaign_data.merge({"EndDate" => params[:end_date].strftime("%Y-%m-%dT%H:%M:%SZ")})
        else
          campaign_data = campaign_data.merge({"EndDate" => nil})
        end
        if !params[:availability].nil?
          campaign_data = campaign_data.merge({"Availability" => availability})
        end
        if !params[:partner_cost_percentage_fee].nil?
          campaign_data = campaign_data.merge({"PartnerCostPercentageFee" => params[:partner_cost_percentage_fee]})
        end
        if !params[:partner_cpm_fee].nil?
          campaign_data = campaign_data.merge({"PartnerCPMFee" => params[:partner_cpm_fee]})
        end
        if !params[:partner_cpc_fee].nil?
          campaign_data = campaign_data.merge({"PartnerCPCFee" => params[:partner_cpc_fee]})
        end
        return campaign_data
      end
      
    end
  end
end
