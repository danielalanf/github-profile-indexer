# frozen_string_literal: true

# Description: This module is responsible for the searchkick configuration of the User model.
module UserConcern
  extend ActiveSupport::Concern

  included do
    searchkick callbacks: false,
               word_start: %i[name nickname github_url organization location]
  end

  def search_data
    {
      name: name,
      github_url: github_url,
      nickname: nickname,
      organization: organization,
      location: location,
      profile_image: image_url
    }
  end
end
