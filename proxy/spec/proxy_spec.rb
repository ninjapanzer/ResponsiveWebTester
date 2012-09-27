require 'spec_helper'
RSpec.configure do |config|
  config.before(:each) do
    @proxy = Proxy.new
    @uri = URI.parse('http://google.com')
    @headers = {"HTTP_USER_AGENT"=>"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5"}
  end
end

describe Proxy do
end

describe "#new" do
  before(:each) do
      @proxy = Proxy.new
      @uri = URI.parse('http://google.com')
    end
  it "Creates a new Object" do
    Proxy.new.should be_instance_of Proxy
  end
  it "Test for @proxy" do
    @proxy.should be_instance_of Proxy
  end
end

describe "#fetch" do
    it "Should have a URI and some Headers" do
      @uri.should be_instance_of URI::HTTP
      @uri.to_s.should be_instance_of String
      @headers.size > 0
    end
    it "Should create an HTTP Object that requests the URI and attaches the Headers" do
      passin = {:uri=>@uri, :headers=>@headers}
      @proxy.fetch(passin).should be_instance_of String
    end
end
