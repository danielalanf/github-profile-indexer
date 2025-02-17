require 'rails_helper'

RSpec.describe UserDecorator do
  let(:user) { create(:user, :complete) }
  let(:decorated_user) { user.decorate }

  describe '#profile_image' do
    it 'returns the default image when image_url is not present' do
      user.image_url = nil
      expect(decorated_user.profile_image).to include("usuario-placeholder.png")
    end

    it 'returns the user image when image_url is present' do
      user.image_url = "https://example.com/image.png"
      expect(decorated_user.profile_image).to include("https://example.com/image.png")
    end
  end

  describe '#github_link' do
    it 'returns a link to the GitHub profile with the correct URL' do
      expect(decorated_user.github_link).to include(user.original_github_url)
    end
  end

  describe '#followers' do
    it 'returns the formatted followers count' do
      expect(decorated_user.followers).to eq("24K")
    end
  end

  describe '#following' do
    it 'returns the formatted following count' do
      expect(decorated_user.following).to eq(11)
    end
  end

  describe '#stars' do
    it 'returns the formatted stars count' do
      expect(decorated_user.stars).to eq(160)
    end
  end

  describe '#last_year_contributions' do
    it 'returns the formatted last year contributions count' do
      expect(decorated_user.last_year_contributions).to eq(0)
    end
  end

  describe '#location_with_icon' do
    it 'returns the location with an icon when location is present' do
      expect(decorated_user.location_with_icon).to include("San Francisco")
      expect(decorated_user.location_with_icon).to include("fa-map-marker-alt")
    end

    it 'returns nil when location is not present' do
      user.location = nil
      expect(decorated_user.location_with_icon).to be_nil
    end
  end

  describe '#organization_with_icon' do
    it 'returns the organization with an icon when organization is present' do
      expect(decorated_user.organization_with_icon).to include("GitHub")
      expect(decorated_user.organization_with_icon).to include("fa-building")
    end

    it 'returns nil when organization is not present' do
      user.organization = nil
      expect(decorated_user.organization_with_icon).to be_nil
    end
  end
end
