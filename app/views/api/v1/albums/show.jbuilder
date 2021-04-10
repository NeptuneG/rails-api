# frozen_string_literal: true

json.extract! resource, :id, :title, :description, :release_year
json.genre resource.genre.name
json.artist resource.artist.name
