# frozen_string_literal: true

class AddReleaseYearToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :release_year, :integer
  end
end
