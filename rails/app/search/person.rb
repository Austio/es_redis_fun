module Search
  class Person < Search::Base
    def initialize(person = nil)
      @obj = person
    end

    def index
      'person'
    end

    def find_by_name(name)
      q = {
        query: {
          match: {
            name: name
          }
        }
      }

      search(q)
    end

    def to_elasticsearch
      {
        name: @obj.name,
        created_at: @obj.epoch_created_at,
        updated_at: @obj.epoch_updated_at
      }
    end

    def update
      update_index(index, @obj.id, to_elasticsearch)
    end

    def mapping
      {
          name: {
              type: "text"
          },
          created_at: {
              type: "date"
          },
          updated_at: {
              type: "date"
          }
      }
    end
  end
end
