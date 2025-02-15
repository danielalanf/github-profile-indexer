require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a name and a valid, unique github_url' do
      user = User.new(name: 'John Doe', github_url: 'https://github.com/johndoe')
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: nil, github_url: 'https://github.com/johndoe')
      expect(user).to_not be_valid
    end

    it 'is not valid without a github_url' do
      user = User.new(name: 'John Doe', github_url: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid github_url' do
      user = User.new(name: 'John Doe', github_url: 'invalid_url')
      expect(user).to_not be_valid
    end

    it 'is not valid with a non-unique github_url' do
      User.create!(name: 'Jane Doe', github_url: 'https://github.com/janedoe')
      user = User.new(name: 'John Doe', github_url: 'https://github.com/janedoe')
      expect(user).to_not be_valid
    end
  end

  describe '#rescanner' do
    it 'calls the scrapper method' do
      user = User.new(name: 'John Doe', github_url: 'https://github.com/johndoe')
      expect(user).to receive(:scrapper)
      user.rescanner
    end
  end

  describe '#original_github_url' do
    it 'returns the original github_url from the slug' do
      short_url = ShortUrl.create!(long_url: 'https://github.com/johndoe', slug: 'johndoe')
      user = User.new(name: 'John Doe', github_url: 'https://tinyurl.com/johndoe')
      expect(user.original_github_url).to eq('https://github.com/johndoe')
    end
  end

  describe 'callbacks' do
    it 'calls generate_shortner_url before save' do
      user = User.new(name: 'John Doe', github_url: 'https://github.com/johndoe')
      expect(user).to receive(:generate_shortner_url)
      user.save
    end

    it 'calls scrapper before save' do
      user = User.new(name: 'John Doe', github_url: 'https://github.com/johndoe')
      expect(user).to receive(:scrapper)
      user.save
    end
  end
end
