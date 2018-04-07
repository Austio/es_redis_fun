require 'sinatra'
require 'sinatra/reloader'
require 'net/http'
require 'pry'
require 'json'

get '/' do
  { hi: 'ya' }.to_json

end
