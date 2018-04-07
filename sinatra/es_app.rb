require 'sinatra'
require 'sinatra/reloader'
require 'net/http'
require 'pry'
require_relative './helpers/es_utils'

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

post '/indexes' do
  es_put_index(params['index'])
end

get '/indexes' do
  indexes = es_get('/_cat/indices?v&pretty').split(' ')
  erb :indexes_list, locals: { indexes: indexes }
end

get '/indexes/new' do
  index = params["index"] || ''
  aliases = ""
  mappings = ""
  erb :indexes_form, locals: { index: index, aliases: aliases, mappings: mappings}
end

get '/indexes/:index' do
  index = params['index']
  res = JSON.parse es_get("/#{index}")

  if res["error"]
    redirect("/indexes/new?index=#{index}")
  end


  aliases = res[index]["aliases"]
  mappings = res[index]["mappings"]

  erb :indexes_form, locals: { index: index, aliases: aliases, mappings: mappings}
end
