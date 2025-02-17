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

  trait :complete do
    name { "Tom Preston-Werner" }
    github_url { "https://github.com/mojombo" }
    image_url { "https://avatars.githubusercontent.com/u/1?v=4" }
    followers { 24198 }
    following { 11 }
    stars { 160 }
    last_year_contributions { 0 }
    location { "San Francisco" }
    organization { "@chatterbugapp, @redwoodjs, @preston-werner-ventures" }
  end
end
