# frozen_string_literal: true

class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :title, null: false, limit: 255
      t.string :description
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
