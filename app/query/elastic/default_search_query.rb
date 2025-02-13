module Elastic
  class DefaultSearchQuery
    def initialize(query, options = {})
      @query = query
      @options = options
    end

    def search_ids
      ids_options
      search.map { |q| q.id.to_i }
    end

    private

    attr_reader :options, :query

    def ids_options
      default_id_options
      @options.merge! select: [ "id" ]
    end

    def default_id_options
      default_options
      @options.merge! load: false, misspellings: false, limit: 9999
    end
  end
end
