require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "validations" do
    it "is valid with a name and a valid, unique github_url" do
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a github_url" do
      user.github_url = nil
      expect(user).to_not be_valid
    end

    it "is not valid with an invalid github_url" do
      user.github_url = "invalid_url"
      expect(user).to_not be_valid
    end

    it "is not valid with a non-unique github_url" do
      create(:user, github_url: "https://github.com/unique_user")
      user.github_url = "https://github.com/unique_user"
      expect(user).to_not be_valid
    end
  end

  describe "#rescanner" do
    it "calls the scrapper method" do
      expect(user).to receive(:scrapper)
      user.rescanner
    end
  end

  describe "#original_github_url" do
    it "returns the original github_url from the slug" do
      create(:short_url, long_url: "https://github.com/johndoe", slug: "johndoe")
      user.github_url = "https://tinyurl.com/johndoe"
      expect(user.original_github_url).to eq("https://github.com/johndoe")
    end
  end

  describe "callbacks" do
    it "calls generate_shortner_url before save" do
      expect(user).to receive(:generate_shortner_url)
      user.save
    end

    it "calls scrapper before save" do
      expect(user).to receive(:scrapper)
      user.save
    end
  end

  describe "github_url_exists" do
    it "adds an error if the github_url does not exist" do
      allow(HTTParty).to receive(:get).and_return(double(code: 404))
      user.github_url_exists
      expect(user.errors[:github_url]).to include("does not exist")
    end

    it "does not add an error if the github_url exists" do
      allow(HTTParty).to receive(:get).and_return(double(code: 200))
      user.github_url_exists
      expect(user.errors[:github_url]).to be_empty
    end
  end
end
