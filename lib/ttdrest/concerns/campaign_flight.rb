module Ttdrest
  module Concerns
    module CampaignFlight

      def update_campaign_flight(campaign_id, campaign_flight_id, budget, daily_budget, start_date, end_date)
        if campaign_id && campaign_flight_id
          flight_data = {
            'BudgetInAdvertiserCurrency' => budget,
            'DailyTargetInAdvertiserCurrency' => daily_budget,
            'CampaignId' => campaign_id,
            'CampaignFlightId' => campaign_flight_id,
            'StartDateInclusiveUTC' => start_date,
            'EndDateExclusiveUTC' => end_date
          }
          return data_put("/campaignflight", 'application/json', flight_data.to_json)
        end
      end
    end
  end
end
