# frozen_string_literal: true

class User < ApplicationRecord
  include UserConcern

  after_commit :reindex, on: [ :create, :update, :destroy ]
  before_save :generate_shortner_url, :scrapper

  validates :name, presence: true
  validates :github_url, presence: true, format: URI.regexp(%w[http https]), uniqueness: true

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
    scrapper = Scrapper.new(github_url: original_github_url)
    self.attributes = self.attributes.merge(
        scrapper.find_attributes
    )
  end
end
