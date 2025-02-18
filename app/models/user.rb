# frozen_string_literal: true

class User < ApplicationRecord
  include UserConcern

  validates :name, presence: true
  validates :github_url, presence: true, format: URI.regexp(%w[http https]), uniqueness: true
  validate :github_url_exists

  after_commit :reindex, on: [ :create, :update, :destroy ]
  before_save :generate_shortner_url, :scrapper

  def rescanner
    scrapper
  end

  def original_github_url
    slug = self.github_url.split("/").last
    ShortUrl.find_by(slug: slug)&.long_url
  end

  private

  def generate_shortner_url
    return unless self.github_url_changed?
    self.github_url = ShortUrl.generate(self.github_url)
  end

  def scrapper
    return unless original_github_url
    scrapper = Scrapper.new(github_url: original_github_url, user: self)
    self.attributes = self.attributes.merge(
        scrapper.find_attributes
    )
  end

  def github_url_exists
    response = HTTParty.get(self.github_url)
    if response.code == 404
      errors.add(:github_url, "profile not exist on github")
    end
  rescue StandardError => e
    errors.add(:base, "could not be verified: #{e.message}")
  end
end
