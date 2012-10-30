require 'spec_helper'
RSpec.configure do |config|
  config.before(:each) do
    
  end
end

describe Proxy do
  before(:all) do
    @proxy = Proxy.new
    @uri = URI.parse('http://google.com')
    @headers = {"HTTP_USER_AGENT"=>"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5"}
    @passin = {:uri=>@uri, :headers=>@headers}
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
    it "Should create an Mechanize::Page Object that requests the URI and attaches the Headers" do
      passin = {:uri=>@uri, :headers=>@headers}
      @proxy.fetch(passin).should be_instance_of Mechanize::Page
    end
  end

  describe "#mechanize" do
    before(:all) do
        @proxyresult = @proxy.mechanize(@passin)
    end
    it "Should Take URI and Headers and make the page request returning Mechanize::page Object" do
      @proxyresult.should be_instance_of Mechanize::Page
    end
    it "Should set the @mech class instance variable" do
      @proxy.mech.should be_instance_of Mechanize::Page
    end
  end
end