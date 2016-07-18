require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ttdrest::Client do
  describe "with initialized client" do
    let(:client) { Ttdrest::Client.new }

    it '#get_creatives' do
      VCR.use_cassette('get_creatives') do
        expect(client.get_creatives).to eq nil
      end
    end
  end
end
