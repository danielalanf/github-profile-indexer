# frozen_string_literal: true

class CreateShortUrls < ActiveRecord::Migration[7.2]
  def change
    create_table :short_urls do |t|
      t.string :long_url, null: false
      t.string :slug, null: false
      t.index :slug, unique: true
      t.timestamps
    end
  end
end
