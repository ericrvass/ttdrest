require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ttdrest::Client do
  describe 'with initialized client' do
    let(:client) { Ttdrest::Client.new }

    describe '#get_my_reports' do
      xit 'fetches reports' do
        VCR.use_cassette('get_my_reports') do
          expect(client.get_my_reports()).to be_nil
        end
      end

      context "with report date" do
        let(:report_date) { Date.today }

        it 'fetches reports for a date' do
          VCR.use_cassette('get_my_reports_with_date') do
            expect(client.get_my_reports(report_date)).to be_nil
          end
        end

        context 'with schedule name contains' do
          let(:options) { { report_schedule_name_contains: 'Data Elements', } }
          it 'fetches reports for a date' do
            VCR.use_cassette('get_my_reports_with_date_and_schedule_name') do
              expect(client.get_my_reports(report_date, options)).to be_nil
            end
          end
        end
      end
    end
  end
end
