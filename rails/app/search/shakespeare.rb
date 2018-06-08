module Search
  module Shakespeare
    BASE_MAPPING = {
      "line_id": {
        "type": "keyword",
        "index": true
      },
      "play_name": {
        "type": "text",
        "index": true
      },
      "speech_number": {
        "type": "keyword",
        "index": true
      },
      "line_number": {
        "type": "keyword",
        "index": true
      },
      "speaker": {
        "type": "text",
        "index": true
      },
      "text_entry": {
        "type": "text",
        "index": true
      }
    }.freeze

    class Shingle
      def index
        "shakespeare_shingle"
      end

      # PUT to /index
      def special_analyzers
        {
          "settings": {
            "analysis": {
              "filter": {
                "shingle_2": {
                  "type": "shingle",
                  "output_unigrams": "false"
                }
              },
              "analyzer": {
                "completion_analyzer": {
                  "tokenizer": "standard",
                  "filter": [
                    "standard",
                    "lowercase",
                    "shingle_2"
                  ]
                }
              }
            }
          }
        }
      end


      def mapping
        BASE_MAPPING.merge({
          "speaker": {
            "type": "text",
            "analyzer": "completion_analyzer",
            "copy_to": ["completion"]
          },
          "text_entry": {
            "type": "text",
            "analyzer": "completion_analyzer",
            "copy_to": ["completion"]
          },
          "speaker": {
            "type": "text",
            "analyzer": "completion_analyzer",
            "copy_to": ["completion"]
          },
          "completion": {
            "type": "string",
            "analyzer": "completion_analyzer"
          }
        })
      end
    end

    class Specialized
    end

  end
end
