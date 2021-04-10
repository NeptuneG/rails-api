# frozen_string_literal: true

class AddIndices < ActiveRecord::Migration[6.1]
  def change
    add_index :artists, :name
    add_index :albums, :title
  end
end
