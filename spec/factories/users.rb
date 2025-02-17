FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    nickname { "octocat" }
    github_url { "https://github.com/octocat" }
  end

  trait :invalid_github do
    github_url { "https://github.com/invalid_user" }
  end

  trait :valid_github do
    github_url { [
      "https://github.com/matz",
      "https://github.com/rails",
      "https://github.com/github",
      "https://github.com/dhh",
      "https://github.com/defunkt"
    ].sample }
  end
end
