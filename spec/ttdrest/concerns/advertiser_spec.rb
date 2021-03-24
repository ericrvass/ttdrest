require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ttdrest::Client do
  describe "with initialized client" do
    let(:client) { Ttdrest::Client.new }

    describe "#build_advertiser_data" do
      let(:partner_id) { 'foo' }
      let(:advertiser_id) { 'bar' }
      let(:name)        { 'Test Advertiser' }
      let(:domain_address) { 'https://www.terminus.com' }

      let(:params) do 
        {
          domain_address: domain_address
        }
      end

      describe 'partner_id' do
        it 'determines the value of PartnerId' do
          expect(
            client.build_advertiser_data(partner_id, advertiser_id, name, params)
          ).to include({ "PartnerId" => 'foo' })
        end

        context 'when nil' do
          let(:partner_id) { nil }

          it 'does not contain the key at all' do
            expect(
              client.build_advertiser_data(partner_id, advertiser_id, name, params)
            ).to_not include("PartnerId")
          end
        end
      end

      describe 'advertiser_id' do
        it 'determines the value of AdvertiserId' do
          expect(
            client.build_advertiser_data(partner_id, advertiser_id, name, params)
          ).to include({ "AdvertiserId" => 'bar' })
        end

        context 'when nil' do
          let(:advertiser_id) { nil }

          it 'does not contain the key at all' do
            expect(
              client.build_advertiser_data(partner_id, advertiser_id, name, params)
            ).to_not include("AdvertiserId")
          end
        end
      end

      describe 'name' do
        it 'determines the value of AdvertiserName' do
          expect(
            client.build_advertiser_data(partner_id, advertiser_id, name, params)
          ).to include({ "AdvertiserName" => 'Test Advertiser' })
        end

        context 'when nil' do
          let(:name) { nil }

          it 'does not contain the key at all' do
            expect(
              client.build_advertiser_data(partner_id, advertiser_id, name, params)
            ).to_not include("AdvertiserName")
          end
        end
      end

      describe 'params' do
        describe 'domain_address' do
          it 'determines the value of DomainAddress' do
            expect(
              client.build_advertiser_data(partner_id, advertiser_id, name, params)
            ).to include({ "DomainAddress" => 'https://www.terminus.com' })
          end

          context 'when nil' do
            let(:domain_address) { nil }

            it 'does not contain the key at all' do
              expect(
                client.build_advertiser_data(partner_id, advertiser_id, name, params)
              ).to_not include("DomainAddress")
            end
          end

          context 'when empty' do
            let(:domain_address) { '' }

            it 'does not contain the key at all' do
              expect(
                client.build_advertiser_data(partner_id, advertiser_id, name, params)
              ).to_not include("DomainAddress")
            end
          end

          context 'when the key is not provided at all' do
            let(:params) { {} }

            it 'does not contain the key' do
              expect(
                client.build_advertiser_data(partner_id, advertiser_id, name, params)
              ).to_not include("DomainAddress")
            end
          end
        end
      end
    end
  end
end
