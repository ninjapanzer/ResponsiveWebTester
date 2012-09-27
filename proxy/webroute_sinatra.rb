require 'sinatra'
require './proxy'

get '/fetch/:device' do |device|
  p = Proxy.new
  passin = {
    :uri=>params['url'],
    :headers=>{"HTTP_USER_AGENT"=>p.agents[device]}
  }
  #passin[:headers]["HTTP_USER_AGENT"]
  p.fetch(passin)
  #"Hello, #{name}. #{params.inspect}"
end