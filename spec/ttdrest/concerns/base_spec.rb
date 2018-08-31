require 'time'
require 'spec_helper'

RSpec.describe 'Base Concern' do
  let(:client) { Ttdrest::Client.new }

  let(:faux_response) { Struct.new(:code, keyword_init: true) }

  describe 'parse_header_retry' do
    it 'returns nil if the objects lacks Retry-After' do
      expect(client.parse_header_retry({})).to be_nil
    end

    it 'parses numeric waits' do
      expect(client.parse_header_retry({'Retry-After' => '1234'})).to eq 1234
    end

    it 'parses date strings' do
      date = Time.now + 60

      expect(
        client.parse_header_retry({'Retry-After' => date.rfc2822})
      ).to be_within(1).of(60)
    end

    it 'returns nil for invalid dates' do
      date_string = 'Wed, 41 Oct 3015 07:28:00 GMT'

      expect(
        client.parse_header_retry({'Retry-After' => date_string})
      ).to be_nil
    end

    it 'returns nil if the date is in the past' do
      date_string = (Time.now - 60).rfc2822

      expect(
        client.parse_header_retry({'Retry-After' => date_string})
      ).to be_nil
    end

    it 'returns a maximum of 120seconds' do
      date_string = (Time.now + 200).rfc2822

      expect(
        client.parse_header_retry({'Retry-After' => date_string})
      ).to eq 120
    end
  end

  describe '#retryable_http_error?' do
    it 'is false when passed nil' do
      expect(client.retryable_http_error?(nil)).to be_falsy
    end

    it 'is true when the http code is 429' do
      expect(client.retryable_http_error?(faux_response.new(code: '429'))).to be_truthy
    end

    it 'is true when in the 500 range' do
      expect(client.retryable_http_error?(faux_response.new(code: '501'))).to be_truthy
    end

    it 'is false when the http code is 404' do
      expect(client.retryable_http_error?(faux_response.new(code: '404'))).to be_falsy
    end
  end

  describe '#perform_request' do
    let(:connection) { double() }
    let(:request) { double() }
    let(:code) { 200 }

    before do
      allow(connection).to receive(:request).and_return(faux_response.new(code: code))
      allow(client).to receive(:sleep)
    end

    it 'backs off 3 times with jitter' do
      allow(connection).to receive(:request).and_raise(Ttdrest::RecoverableHttpError.new)
      expect(client).to receive(:sleep).with(be_within(0.375).of(1.25 ** 1))
      expect(client).to receive(:sleep).with(be_within(0.469).of(1.25 ** 2))
      expect(client).to receive(:sleep).with(be_within(0.586).of(1.25 ** 3))

      expect(connection).to receive(:request).with(request).exactly(4).times

      expect { client.perform_request(request, connection) }.to raise_error(Ttdrest::RecoverableHttpError)
    end

    it 'respects the retry-after time if detected' do
      allow(connection).to receive(:request).and_raise(Ttdrest::RecoverableHttpError.new)
      allow(client).to receive(:parse_header_retry).and_return(12)
      expect(client).to receive(:sleep).with(12).exactly(3).times

      expect { client.perform_request(request, connection) }.to raise_error(Ttdrest::RecoverableHttpError)
    end

    it 'returns the response when successful' do
      response = faux_response.new(code: '200')

      expect(connection).to receive(:request).with(request).and_return(response)
      expect(client.perform_request(request, connection)).to eq response
    end
  end

end
