require "uri"
require "net/http"
require "ostruct"

module Search
  class Base
    def index
      raise "implement me"
    end

    def mapping
      raise "implement me"
    end

    def mapping_set
      es_set_mapping(index, mapping)
    end

    def mapping_show
      get("/#{index}/_mapping/_doc")
    end

    def get(path = '/', json = nil, req_options = {})
      uri = get_uri(path)

      if !json
        return as_response { Net::HTTP.get_response(uri) }
      end

      request = Net::HTTP::Get.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump(json)

      as_response { Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end }
    end

    def put(path, json, req_options = {})
      uri = get_uri(path)

      request = Net::HTTP::Put.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump(json)

      as_response { Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end }
    end

    def post(path, json, req_options = {})
      uri = get_uri(path)

      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump(json)

      as_response { Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end }
    end

    def update_index(index, id, json)
      put("/#{index}/_doc/#{id}", json)
    end

    def search(json = { })
      get("/#{index}/_search", json)
    end

    def es_mapping_set(index, attrs = {})
      json_mapping_statement = {
        "mappings": {
          "_doc": {
            "properties": attrs
          }
        }
      }

      put("/#{index}", json_mapping_statement)
    end

    def delete(index, req_options = {})
      uri = get_uri("/#{index}")

      request = Net::HTTP::Delete.new(uri)
      request.content_type = "application/json"

      as_response { Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end }
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

      def results
        hits = body.dig("hits", "hits")
        hits && hits.each_with_object([]) do |hit, obj|
          flat_hit = hit.merge(hit["_source"])
          flat_hit.delete("_source")
          obj.push(flat_hit)
        end
      end

      def is_success?
        code == "200" || code == "201"
      end

      def is_error?
        !is_success?
      end

      def error
        body.fetch("error") { nil }
      end
    end
  end
end