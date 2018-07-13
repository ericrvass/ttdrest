require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ttdrest::Client do
  describe 'with initialized client' do
    let(:client) { Ttdrest::Client.new }

    describe '#get_hd_reports' do
      xit 'fetches reports' do
        VCR.use_cassette('get_reports') do
          expect(client.get_reports()).to be nil
        end
      end

      context "with report date" do
        let(:report_date) { Date.today }

        it 'fetches reports for a date' do
          VCR.use_cassette('get_reports_with_date') do
            expect(client.get_reports(report_date)).to be nil
          end
        end
      end
    end
  end
end
