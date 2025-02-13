# frozen_string_literal: true

class User < ApplicationRecord
  include UserConcern

  has_one :bitlink

  after_commit :reindex, on: [ :create, :update, :destroy ]
  before_save :scrapper

  validates :name, presence: true
  validates :github_url, presence: true, format: URI.regexp(%w[http https])

  private

  def scrapper
    scrapper = Scrapper.new(github_url: github_url)
    self.attributes = self.attributes.merge(
        scrapper.find_attributes
    )
  end
end
