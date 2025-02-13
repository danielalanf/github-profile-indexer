# frozen_string_literal: true

class User < ApplicationRecord
  include UserConcern

  has_one :bitlink

  after_commit :reindex, on: [ :create, :update, :destroy ]

  validates :name, presence: true
  validates :github_url, presence: true, format: URI.regexp(%w[http https])
end
