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
          'EndDateExclusiveUTC' => end_date,
          'StartDateInclusiveUTC' => start_date,
        }
      }
      context "update" do
        describe "when campaign_id is NOT present" do
          it 'does not make api call' do
            expect(client).to_not receive(:data_put)
            client.update_campaign_flight(
              campaign_id: nil,
              campaign_flight_id: campaign_flight_id,
              budget: budget,
              daily_budget: daily_budget,
              start_date: start_date,
              end_date: end_date,
            )
          end
        end

        describe "when campaign_flight_id is NOT present" do
          it 'does not make api call' do
            expect(client).to_not receive(:data_put)
            client.update_campaign_flight(
              campaign_id: campaign_id,
              campaign_flight_id: nil,
              budget: budget,
              daily_budget: daily_budget,
              start_date: start_date,
              end_date: end_date,
            )
          end
        end

        describe "when campaign_id and campaign_flight_id are present" do
          it 'sends correct information' do
            expect(client).to receive(:data_put).with("/campaignflight", "application/json", flight_data.to_json)
            client.update_campaign_flight(
              campaign_id: campaign_id,
              campaign_flight_id: campaign_flight_id,
              budget: budget,
              daily_budget: daily_budget,
              start_date: start_date,
              end_date: end_date,
            )
          end

          describe "when start date is nil" do
            it 'does not send start date if start date nil' do
              flight_data.delete("StartDateInclusiveUTC")
              expect(client).to receive(:data_put).with("/campaignflight", "application/json", flight_data.to_json)
              client.update_campaign_flight(
                campaign_id: campaign_id,
                campaign_flight_id: campaign_flight_id,
                budget: budget,
                daily_budget: daily_budget,
                start_date: nil,
                end_date: end_date,
              )
            end
          end
        end
      end
    end
  end
end
