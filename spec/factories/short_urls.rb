FactoryBot.define do
  factory :short_url do
    long_url { "https://github.com/#{Faker::Internet.username}" }
    slug { SecureRandom.base36(8) }
  end
end
