require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ttdrest::Client do
  it 'can initialize' do
    expect(Ttdrest::Client.new).to be_an_instance_of(Ttdrest::Client)
  end
end
