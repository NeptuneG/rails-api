# frozen_string_literal: true

class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists do |t|
      t.string :name, null: false, unique: true, limit: 64
      t.string :description

      t.timestamps
    end

    # rubocop:disable Rails/NotNullColumn
    add_reference :albums, :artist, null: false, foreign_key: true, index: true
    # rubocop:enable Rails/NotNullColumn
  end
end
