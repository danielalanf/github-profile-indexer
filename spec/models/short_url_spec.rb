require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe 'validations' do
    it 'is valid with a valid long_url and unique slug' do
      short_url = ShortUrl.new(long_url: 'https://example.com', slug: 'unique_slug')
      expect(short_url).to be_valid
    end

    it 'is not valid without a long_url' do
      short_url = ShortUrl.new(long_url: nil)
      expect(short_url).to_not be_valid
    end

    it 'is not valid with an invalid long_url' do
      short_url = ShortUrl.new(long_url: 'invalid_url')
      expect(short_url).to_not be_valid
    end

    it 'is not valid with a non-unique slug' do
      ShortUrl.create!(long_url: 'https://example.com', slug: 'non_unique_slug')
      short_url = ShortUrl.new(long_url: 'https://example2.com', slug: 'non_unique_slug')
      expect(short_url).to_not be_valid
    end
  end

  describe '.generate' do
    it 'returns an existing shortened_url if the long_url already exists' do
      existing_short_url = ShortUrl.create!(long_url: 'https://example.com', slug: 'existing_slug')
      expect(ShortUrl.generate('https://example.com')).to eq(existing_short_url.shortened_url)
    end

    it 'creates a new ShortUrl and returns the shortened_url if the long_url does not exist' do
      expect {
        ShortUrl.generate('https://newexample.com')
      }.to change { ShortUrl.count }.by(1)
      expect(ShortUrl.last.long_url).to eq('https://newexample.com')
    end
  end

  describe '#shortened_url' do
    it 'returns the full shortened URL' do
      short_url = ShortUrl.new(long_url: 'https://example.com', slug: 'test_slug')
      expect(short_url.shortened_url).to eq('https://tinyurl.com/test_slug')
    end
  end

  describe '.generate_slug' do
    it 'generates a unique slug for the ShortUrl' do
      short_url = ShortUrl.new(long_url: 'https://example.com')
      ShortUrl.generate_slug(short_url)
      expect(short_url.slug).to be_present
    end
  end
end
