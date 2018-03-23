module ESUtils
  def es_http
    Net::HTTP.new("http://localhost:9200")
  end

  def es_get(path = '/')
    uri = URI("http://localhost:9200#{path}")

    Net::HTTP.get_response(uri).body
  end

  def es_put_index(index)
    request = Net::HTTP::Put.new("/#{index}", 'Content-Type' => 'application/json')
    request.body = {
      "settings": { "number_of_shards" => 1 }
    }
    # request.set_form_data({"users[login]" => "changed"})
    r = es_http.request(request)
    binding.pry
    r
  end

  def search(type)
    es_get('/search/foo')
  end
end
