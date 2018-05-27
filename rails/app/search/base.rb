require "uri"
require "net/http"
require "ostruct"

module Search
  class Base
    def get(path = '/')
      uri = net_uri(path)

      as_response { Net::HTTP.get_response(uri) }
    end

    def put(path, json, req_options = {})
      uri = get_uri(path)

      request = Net::HTTP::Put.new(uri)
      request.content_type = "application/json"
      request.body = json

      Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end

    def post(path, json, req_options = {})
      uri = get_uri(path)

      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump(json)

      Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end

    private

    def get_uri(path, base: "http://localhost:9200")
      if path.first != "/"
        raise "path must begin with /"
      end

      URI("#{base}#{path}")
    end

    def as_response(&block)
      Response.new(yield)
    end

    class Response < Struct.new(:response)
      def code
        @code ||= response.code
      end

      def body
        @body ||= JSON.parse(response.body)
      end

      def total
        body.fetch("hits", {}).fetch("total", 0)
      end

      def is_success?
        code == "200"
      end

      def error
        body.fetch(:error) { nil }
      end
    end
  end
end