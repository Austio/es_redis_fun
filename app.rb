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
  erb :search_form
end

post '/search' do
  erb :search_form, locals: { result: '5' }
end

get '/indexes' do
  indexes = es_get('/_cat/indices?v&pretty').split(' ')

  erb :indexes_list, locals: { indexes: indexes }
end

get '/indexes/new' do
  erb :indexes_form
end

get '/indexes/:id' do
  erb :indexes_form
end
