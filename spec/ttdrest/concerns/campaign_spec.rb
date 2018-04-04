require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ttdrest::Client do
  describe "with initialized client" do
    let(:client) { Ttdrest::Client.new }

    describe "#build_campaign_data" do
      let(:campaign_id) { 1 }
      let(:name)        { 'My Campaign Name' }
      let(:budget)      { 1.01 }
      let(:start_date)  { Date.today }

      describe "campaign_flights" do
        it "set CampaignFlights" do
          dtiac = [ {
            'CampaignId' => 1,
            'CampaignFlightId' => 1,
            'StartDateInclusiveUTC' => start_date,
            'EndDateExclusiveUTC' => 1.month.from_now,
            'BudgetInAdvertiserCurrency' => 'USD',
            'DailyTargetInAdvertiserCurrency' => budget
          }]
          expect(
            client.build_campaign_data(campaign_id, name, budget, start_date, [], { campaign_flights: dtiac })
          ).to include({ "CampaignFlights" => dtiac })
        end
      end

      context "EndDate" do
        it 'sets EndDate to nil when end_date is nil' do
          expect(
            client.build_campaign_data(campaign_id, name, budget, start_date, [], { end_date: nil })
          ).to include({ "EndDate" => nil })
        end

        it 'includes a formatted EndDate when a end_date is sent' do
          end_date = Date.today
          expect(
            client.build_campaign_data(campaign_id, name, budget, start_date, [], { end_date: end_date })
          ).to include({ "EndDate" => end_date.strftime("%Y-%m-%dT%H:%M:%SZ") })
        end

        it 'does not include EndDate when no date is sent' do
          expect(
            client.build_campaign_data(campaign_id, name, budget, start_date, [], { })
          ).to_not include("EndDate")
        end
      end
    end
  end
end
