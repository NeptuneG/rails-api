# frozen_string_literal: true

json.data resources do |artist|
  json.extract! artist, :id, :name, :description, :slug
end
