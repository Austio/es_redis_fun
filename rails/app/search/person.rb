module Search
  class Person < Search::Base

    def index
      'person'
    end

    def from_ar(ar)
      {
        name: ar.name,
        created_at: ar.created_at,
        updated_at: ar.updated_at
      }
    end

    def update(ar)
system %(
curl "localhost:9200/#{index}/#{ar.id}" -H 'Content-Type: application/json' -d'
#{from_ar(ar)}
'
)
    end

    def search
system %(
curl "localhost:9200/#{index}/_search" -H 'Content-Type: application/json' -d'
{
  "query":{
     "match_all": {}
  }
}
')
    end

    def create_mapping
system %(
curl -X PUT "localhost:9200/person" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "_doc": {
      "properties": {
        "name": {
          "type": "text"
        },
        "created_at": {
          "type": "date"
        },
        "updated_at": {
          "type": "date"
        }
      }
    }
  }
}
')
    end
  end
end
