require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'pry'

describe Ttdrest::Client do
  describe "with initialized client" do
    let(:client) { Ttdrest::Client.new }

    let(:owner_id) { 1 }
    let(:owner_type) { 'campaign' }
    let(:start_date) { Time.now }
    let(:fee_1) do
      {
        description: 'Foo Fee',
        amount: 678,
        fee_type: 'FeeCPM',
      }
    end
    let(:fee_2) do
      {
        description: 'Bar Fee',
        amount: 404,
        fee_type: 'PartnerCostPercentage',
      }
    end
    let(:fees) { [fee_1, fee_2] }

    let(:additional_fees_body_response) { { 'Foo' => 'bar' } }

    describe '#get_additional_fees' do
      it 'builds the path with the given id and type' do
        expect(client).to receive(:get).with('/additionalfees/campaign/1', {})
        client.get_additional_fees(owner_id, owner_type)
      end
    end

    describe '#create_additional_fees' do
      it 'builds the additional fees body and submits it to the create api' do
        # We test building the body, so just make sure we use it and it's converted to json
        expect(client).to receive(:additional_fees_body).and_return(additional_fees_body_response)
        expect(client).to receive(:data_post).with('/additionalfees', 'application/json', "{\"Foo\":\"bar\"}")
        client.create_additional_fees(owner_id,owner_type,start_date,fees)
      end
    end

    describe '#update_additional_fees' do
      it 'builds the additional fees body and submits it to the create api' do
        # We test building the body, so just make sure we use it and it's converted to json
        expect(client).to receive(:additional_fees_body).and_return(additional_fees_body_response)
        expect(client).to receive(:data_put).with('/additionalfees', 'application/json', "{\"Foo\":\"bar\"}")
        client.update_additional_fees(owner_id,owner_type,start_date,fees)
      end
    end

    describe "#additional_fees_body" do
      it 'builds and populates the StartDateUtc attribute with iso8601 format' do
        expect(
          client.additional_fees_body(owner_id, owner_type, start_date, fees)
        ).to include({ "StartDateUtc" => start_date.utc.strftime("%Y-%m-%dT%H:%M:%SZ") })
      end

      it 'builds OwnerId attribute' do
        expect(
          client.additional_fees_body(owner_id, owner_type, start_date, fees)
        ).to include({ 'OwnerId' => owner_id })
      end

      it 'builds OwnerType attribute' do
        expect(
          client.additional_fees_body(owner_id, owner_type, start_date, fees)
        ).to include({ 'OwnerType' => owner_type })
      end

      it 'builds Fees attribute using each fee provided' do
        expect(
          client.additional_fees_body(owner_id, owner_type, start_date, fees)['Fees']
        ).to include({ 
          'Description' => fee_1[:description],
          'Amount' => fee_1[:amount],
          'FeeType' => fee_1[:fee_type]
        })
        expect(
          client.additional_fees_body(owner_id, owner_type, start_date, fees)['Fees']
        ).to include({ 
          'Description' => fee_2[:description],
          'Amount' => fee_2[:amount],
          'FeeType' => fee_2[:fee_type]
        })
      end

      context 'with raw JSON fees' do
        let(:fee_1) do
          {
            'Description' => 'Foo Fee',
            'Amount' => 678,
            'FeeType' => 'FeeCPM',
          }
        end
        let(:fee_2) do
          {
            'Description' => 'Bar Fee',
            'Amount' => 404,
            'FeeType' => 'PartnerCostPercentage',
          }
        end

        it 'builds Fees attribute using each fee provided' do
          expect(
            client.additional_fees_body(owner_id, owner_type, start_date, fees)['Fees']
          ).to include({ 
            'Description' => fee_1['Description'],
            'Amount' => fee_1['Amount'],
            'FeeType' => fee_1['FeeType']
          })
          expect(
            client.additional_fees_body(owner_id, owner_type, start_date, fees)['Fees']
          ).to include({ 
            'Description' => fee_2['Description'],
            'Amount' => fee_2['Amount'],
            'FeeType' => fee_2['FeeType']
          })
        end
      end
    end
  end
end

