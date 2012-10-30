require './proxy'

p = Proxy.new

passin = {
    :uri=>"http://google.com",
    :headers=>{"HTTP_USER_AGENT"=>p.agents["iphone4"]}
  }

  p.proxy_it passin
  