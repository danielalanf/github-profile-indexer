# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :github_url
      t.string :nickname, limit: 50
      t.integer :followers
      t.integer :following
      t.integer :stars
      t.integer :last_year_contributions, limit: 1
      t.string :image_url
      t.string :organization
      t.string :location

      t.timestamps
    end
  end
end
