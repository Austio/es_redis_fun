module Config
  class TypesController < ApplicationController
    def index
      mappings = es_get('/_cat/indices?v&pretty')

      render json: JSON.pretty_generate(mappings)
    end
  end
end