# frozen_string_literal: true

class CreateAssets < ActiveRecord::Migration[6.1]
  def change
    create_table :assets do |t|
      t.string :title, null: false, limit: 64
      t.string :description
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
