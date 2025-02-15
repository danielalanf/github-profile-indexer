require "rails_helper"

RSpec.describe ShortUrl, type: :model do
  let(:short_url) { create(:short_url) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(short_url).to be_valid
    end

    it "is not valid without a long_url" do
      short_url.long_url = nil
      expect(short_url).to_not be_valid
    end

    it "is not valid with an invalid long_url" do
      short_url.long_url = "invalid_url"
      expect(short_url).to_not be_valid
    end

    it "is not valid with a non-unique slug" do
      duplicate_short_url = build(:short_url, slug: short_url.slug)
      expect(duplicate_short_url).to_not be_valid
    end
  end

  describe ".generate" do
    it "returns an existing shortened_url if the long_url already exists" do
      existing_short_url = create(:short_url, long_url: "https://github.com/existing_user")
      expect(ShortUrl.generate("https://github.com/existing_user")).to eq(existing_short_url.shortened_url)
    end

    it "creates a new ShortUrl and returns the shortened_url if the long_url does not exist" do
      expect {
        ShortUrl.generate("https://github.com/new_user")
      }.to change { ShortUrl.count }.by(1)
      expect(ShortUrl.last.long_url).to eq("https://github.com/new_user")
    end
  end

  describe "#shortened_url" do
    it "returns the full shortened URL" do
      expect(short_url.shortened_url).to eq("https://tinyurl.com/#{short_url.slug}")
    end
  end

  describe ".generate_slug" do
    it "generates a unique slug for the ShortUrl" do
      new_short_url = build(:short_url)
      ShortUrl.generate_slug(new_short_url)
      expect(new_short_url.slug).to be_present
    end
  end
end
