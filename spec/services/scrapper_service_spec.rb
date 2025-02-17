require 'rails_helper'

RSpec.describe Scrapper, type: :service do
  let(:user) { create(:user) }
  let(:github_url) { user.original_github_url }
  let(:scrapper) { Scrapper.new(github_url: github_url, user: user) }

  describe '#find_attributes', :vcr do
    it 'returns the correct attributes from the GitHub page' do
      VCR.use_cassette('github_profile_exist') do
        attributes = scrapper.find_attributes

        expect(attributes).to include(
          nickname: 'octocat',
          image_url: a_string_including('https://avatars.githubusercontent.com/u/583231?v=4'),
          followers: eq(17000),
          following: eq(9),
          stars: eq(4),
          last_year_contributions: eq(0),
          organization: eq("@github"),
          location: eq("San Francisco")
        )
      end
    end
  end
end
