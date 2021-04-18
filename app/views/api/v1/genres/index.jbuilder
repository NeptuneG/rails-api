# frozen_string_literal: true

json.data data do |genre|
  json.extract! genre, :id, :name
end

json.meta meta
