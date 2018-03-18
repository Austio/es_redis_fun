require 'sinatra'
require 'sinatra/reloader'
require 'net/http'
require 'pry'

get '/' do
  'Howdy!'
end

get '/es' do
  uri = URI.parse('http://localhost:9200')
  h = Net::HTTP.new uri.host, uri.port
  req = Net::HTTP::Get.new '/'

  res = h.request req
  res.body
end
