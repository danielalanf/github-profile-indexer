# frozen_string_literal: true


class ShortUrl < ApplicationRecord
  validates_presence_of :long_url
  validates :long_url, format: URI.regexp(%w[http https])
  validates_uniqueness_of :slug

  BASE_URL = "https://tinyurl.com"

  def self.generate(url)
    short_url = ShortUrl.where(long_url: url).first
    return short_url.shortened_url if short_url

    short_url = ShortUrl.new(long_url: url)

    generate_slug(short_url)

    short_url.shortened_url
  end

  def shortened_url
    URI.parse("#{BASE_URL}/#{slug}")&.to_s
  end

  def self.generate_slug(short_url)
    short_url.slug = SecureRandom.base36(8)
    short_url.save!
  end
end
