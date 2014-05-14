module Ttdrest
  module Concerns
    module Campaign

      def get_campaigns(options = {})
        auth_token = self.auth_token || options[:auth_token]
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/campaigns/#{advertiser_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def create_campaign(name, budget_in_dollars, start_date, campaign_conversion_reporting_columns = [], options = {})
        auth_token = self.auth_token || options[:auth_token]
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/campaign"
        content_type = 'application/json'
        campaign_data = {
          "AdvertiserId" => advertiser_id,
          "CampaignName" => name,
          "BudgetInUSDollars" => budget_in_dollars,
          "StartDate" => start_date,
          "CampaignConversionReportingColumns" => campaign_conversion_reporting_columns
          }
        params = options[:params] || {}
        if !params[:description].nil?
          campaign_data = campaign_data.merge({"Description" => params[:description]})
        end
        if !params[:end_date].nil?
          campaign_data = campaign_data.merge({"EndDate" => params[:end_date]})
        end
        if !params[:budget_in_impressions].nil?
          campaign_data = campaign_data.merge({"BudgetInImpressions" => params[:budget_in_impressions]})
        end
        if !params[:daily_budget_in_dollars].nil?
          campaign_data = campaign_data.merge({"DailyBudgetInUSDollars" => params[:daily_budget_in_dollars]})
        end
        if !params[:daily_budget_in_impressions].nil?
          campaign_data = campaign_data.merge({"DailyBudgetInImpressions" => params[:daily_budget_in_impressions]})
        end
        result = data_post(path, content_type, campaign_data.to_json)
        return result
      end
      
    end
  end
end