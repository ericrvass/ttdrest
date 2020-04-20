require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ttdrest::Client do
  describe "with initialized client" do
    let(:client) { Ttdrest::Client.new }

    describe "#build_campaign_data" do
      let(:campaign_id) { 1 }
      let(:name)        { 'My Campaign Name' }
      let(:budget)      { 1.01 }
      let(:start_date)  { Date.today }

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

      context 'Fees' do
        let(:partner_cost_percentage_fee) { 1 }

        let(:partner_cpm_fee) do
          {
            'Amount' => 0.01,
            'CurrencyCode' => 'USD',
          }
        end

        let(:partner_cpc_fee) do
          {
            'Amount' => 0.02,
            'CurrencyCode' => 'USD',
          }
        end

        let(:params) do
          {
            partner_cost_percentage_fee: partner_cost_percentage_fee,
            partner_cpm_fee: partner_cpm_fee,
            partner_cpc_fee: partner_cpc_fee,
          }
        end

        it 'populates PartnerCostPercentageFee' do
          expect(
            client.build_campaign_data(campaign_id, name, budget, start_date, [], params)
          ).to include({ "PartnerCostPercentageFee" => partner_cost_percentage_fee })
        end

        it 'populates PartnerCPMFee' do
          expect(
            client.build_campaign_data(campaign_id, name, budget, start_date, [], params)
          ).to include({ "PartnerCPMFee" => partner_cpm_fee})
        end

        it 'populates PartnerCPCFee' do
          expect(
            client.build_campaign_data(campaign_id, name, budget, start_date, [], params)
          ).to include({ "PartnerCPCFee" => partner_cpc_fee})
        end

        context 'when additional_fee_card is present' do
          let(:additional_fee_card) do
            {
              "StartDateUtc" => "2020-04-15T21:15:49.0540308+00:00",
              "Fees" => [
                {
                  "Description" => "sample string 1",
                  "Amount" => 2,
                  "FeeType" => "MediaCostPercentage"
                },
                {
                  "Description" => "sample string 1",
                  "Amount" => 2,
                  "FeeType" => "MediaCostPercentage"
                },
                {
                  "Description" => "sample string 1",
                  "Amount" => 2,
                  "FeeType" => "MediaCostPercentage"
                }
              ],
              "OwnerId" => "sample string 2",
              "OwnerType" => "sample string 3"
            }
          end

          let(:params) do
            {
              additional_fee_card: additional_fee_card,
            }
          end

          context 'when campaign_id is present' do
            # this attribute is only available on create, not update
            it 'does not send AdditionalFeeCardOnCreate' do
              expect(
                client.build_campaign_data(campaign_id, name, budget, start_date, [], params).keys
              ).to_not include("AdditionalFeeCardOnCreate")
            end
          end

          context 'when campaign_id is not present' do
            it 'populates AdditionalFeeCardOnCreate' do
              expect(
                client.build_campaign_data(nil, name, budget, start_date, [], params)
              ).to include({ "AdditionalFeeCardOnCreate" => additional_fee_card})
            end
          end
        end
      end
    end
  end
end
