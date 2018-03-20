require 'sinatra'
require 'sinatra/reloader'
require 'net/http'
require 'pry'

module ESUtils
  def es_get(path = '/')
    uri = URI("http://localhost:9200#{path}")

    Net::HTTP.get_response(uri).body
  end

  def search(type)
    es_get('/search/foo')
  end
end

helpers ESUtils

get '/' do
  redirect('/search')
end

get '/search' do
  erb :search
end
