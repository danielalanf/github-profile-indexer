# frozen_string_literal: true

class CreateBitlinks < ActiveRecord::Migration[7.2]
  def change
    create_table :bitlinks do |t|
      t.references :user, null: false
      t.string :short_url
      t.string :long_url
      t.timestamps
    end

    add_index :bitlinks, :long_url, unique: true
  end
end
