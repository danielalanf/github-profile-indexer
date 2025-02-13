module Elastic
  class UserSearchQuery < DefaultSearchQuery
    def search
      default_options
      User.search(query, **options)
    end

    private

    def default_options
      options.reverse_merge!(
        load: false,
        match: :word_start,
        fields: [ :name ],
        limit: 10,
        misspellings: { below: 5 })
    end
  end
end
