require 'sinatra'
require 'sinatra/reloader'
require 'net/http'
require 'pry'


module ESUtils
  ES_HOST =
  def es_get(path = '/',)
    Net::HTTP.get('http://localhost:9200', path)
  end
end

helpers ESUtils


get '/' do
  'Howdy!'
end

get '/es' do
  [200, es_get]
end
