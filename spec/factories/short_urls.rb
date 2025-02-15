FactoryBot.define do
  factory :short_url do
    long_url { "https://github.com/danielalanf" }
    slug { SecureRandom.base36(8) }
  end
end
