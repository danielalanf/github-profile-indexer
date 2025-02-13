FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    github_url { "https://github.com/#{nickname}" }
    nickname { name.parameterize }
  end
end
