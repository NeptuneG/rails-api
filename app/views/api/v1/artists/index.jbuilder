# frozen_string_literal: true

json.data data do |artist|
  json.extract! artist, :id, :name, :description, :slug
end

json.meta meta
