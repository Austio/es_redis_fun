require 'sinatra'
require 'sinatra/reloader'
require 'net/http'
require 'pry'

module ESUtils
  def es_get(path = '/')
    uri = URI("http://localhost:9200#{path}")

    Net::HTTP.get_response(uri).body
  end
end

helpers ESUtils


get '/' do
  'Howdy!'
end

get '/es' do
  [200, es_get]
end
