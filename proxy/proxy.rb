require 'mechanize'
require 'uri'


class Proxy
  attr_accessor :agents
  def initialize()
    @agents = {"iphone4"=>"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5"}
  end
  
=begin
  #Fetch obj map:
    :uri=> URI object with a valid url
    :headers=> Hash of headers to be injected into the request
=end  
  def fetch (obj)
    agent = Mechanize.new
    agent.user_agent = obj[:headers]["HTTP_USER_AGENT"]
    obj[:headers].delete_if do |key, value|
      key == "HTTP_USER_AGENT"
    end
    agent.request_headers = obj[:headers]
    resp = agent.get obj[:uri]
    resp.body
  end
end