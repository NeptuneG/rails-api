# frozen_string_literal: true

json.data data do |album|
  json.extract! album, :id, :title, :description, :release_year
  json.genre album.genre.name
  json.artist album.artist.name
end

json.meta meta
