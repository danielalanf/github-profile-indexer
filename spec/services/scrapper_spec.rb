require "rails_helper"

RSpec.describe Scrapper, type: :service do
  let(:user) { create(:user) }
  let(:github_url) { "https://github.com/octocat" }
  let(:scrapper) { Scrapper.new(github_url: github_url, user: user) }

  describe "#find_attributes", :vcr do
    it "returns the correct attributes from the GitHub page" do
      attributes = scrapper.find_attributes

      expect(attributes).to include(
        nickname: "octocat",
        image_url: a_string_including("https://avatars.githubusercontent.com/u/583231"),
        followers: be_a(Integer),
        following: be_a(Integer),
        stars: be_a(Integer),
        last_year_contributions: be_a(Integer),
        organization: be_a(String).or(be_nil),
        location: be_a(String).or(be_nil)
      )
    end

    it "adds an error if the github_url does not exist" do
      allow(HTTParty).to receive(:get).and_return(double(code: 404))
      scrapper.find_attributes
      expect(user.errors[:github_url]).to include("not found")
    end
  end
end
