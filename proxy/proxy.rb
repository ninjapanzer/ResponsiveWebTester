require 'mechanize'
require 'uri'


class Proxy
  attr_accessor :agents
  attr_reader :mech, :giri
  def initialize()
    @agents = {
      "iphone4"=>"Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5",
      "ipad"=>"Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B334b Safari/531.21.10"}
  end
  
=begin
  #Fetch obj map:
    :uri=> URI object with a valid url
    :headers=> Hash of headers to be injected into the request
=end  
  def fetch (obj)
    resp = mechanize obj
  end

  def proxy_it (obj)
    resp = mechanize obj
    undetermined_resp = girit resp.content
    determined_resp = force_determinism 
    resp = determined_resp.to_html
  end

  def mechanize (obj)
    agent = Mechanize.new
    agent.user_agent = obj[:headers]["HTTP_USER_AGENT"]
    obj[:headers].delete_if do |key, value|
      key == "HTTP_USER_AGENT"
    end
    agent.request_headers = obj[:headers]
    @mech = resp = agent.get obj[:uri]
    #girit resp.content
  end
=begin
  Silly Circular logic for testing at the moment
=end
  def girit (html)
    @giri = Nokogiri.parse(html)
    @giri.to_html
  end

private

  def force_determinism
    determined_giri = @giri.clone
    determined_giri.search("a").each do |link|
      if link ["href"] != nil &&  !link["href"].include?("http") && link["href"].scan(/\([a-zA-Z]*[\d+]*[a-zA-Z]*\)/).size <= 0
        #puts link["href"]
        link["href"] = link["href"][0] == "/" ? link["href"] : "/" + link["href"]
        link["href"] = @mech.uri.scheme.to_s + "\://" + @mech.uri.host.to_s + link["href"]
        #puts link["href"]
      end
    end
    determined_giri
  end

end