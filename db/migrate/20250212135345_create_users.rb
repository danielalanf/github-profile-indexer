# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :github_url, null: false
      t.index :github_url, unique: true
      t.string :nickname, limit: 100
      t.integer :followers, default: 0, null: false
      t.integer :following, default: 0, null: false
      t.integer :stars, default: 0, null: false
      t.integer :last_year_contributions, default: 0, null: false
      t.string :image_url
      t.string :organization
      t.string :location

      t.timestamps
    end
  end
end
