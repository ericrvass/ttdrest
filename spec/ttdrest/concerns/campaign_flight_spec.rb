require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ttdrest::Client do
  describe "with initialized client" do
    let!(:client) { Ttdrest::Client.new }

    describe "#update_campaign_flight" do
      let(:campaign_id)         { '1testid' }
      let(:campaign_flight_id)  { 1 }
      let(:budget)              { 10 }
      let(:daily_budget)        { 1 }
      let(:start_date)          { 30.days.ago }
      let(:end_date)            { 30.days.from_now }
      let(:flight_data) {
        {
          'BudgetInAdvertiserCurrency' => budget,
          'DailyTargetInAdvertiserCurrency' => daily_budget,
          'CampaignId' => campaign_id,
          'CampaignFlightId' => campaign_flight_id,
          'StartDateInclusiveUTC' => start_date,
          'EndDateExclusiveUTC' => end_date
        }
      }
      context "update" do
        it 'sets EndDate to nil when end_date is nil' do
          expect(client).to receive(:data_put).with("/campaignflight", "application/json", flight_data.to_json)
          client.update_campaign_flight(
            campaign_id: campaign_id,
            campaign_flight_id: campaign_flight_id,
            budget: budget,
            daily_budget: daily_budget,
            start_date: start_date,
            end_date: end_date
          )
        end
      end
    end
  end
end
