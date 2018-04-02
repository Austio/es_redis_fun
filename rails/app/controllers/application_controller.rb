require 'net/http'
class ApplicationController < ActionController::Base
  def es_http
    Net::HTTP.new("http://localhost:9200")
  end

  def es_get(path = '/')
    uri = URI("http://localhost:9200#{path}")

    Net::HTTP.get_response(uri).body
  end
end
