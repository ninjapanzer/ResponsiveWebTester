require 'spec_helper'
RSpec.configure do |config|
  config.before(:each) do
    @proxy = Proxy.new
    @url = 'http://google.com'
  end
end
describe Proxy do
end

describe "#new" do
  before(:each) do
      @proxy = Proxy.new
      @url = 'http://google.com'
    end
  it "Creates a new Object" do
    Proxy.new.should be_instance_of Proxy
  end
  it "Test for @proxy" do
    @proxy.should be_instance_of Proxy
  end
end

describe "#fetch" do
    it "Takes a URL and returns the HTML of the site as a String" do
      @proxy.fetch(@url).should be_instance_of String
    end
end
