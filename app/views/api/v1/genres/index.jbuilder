# frozen_string_literal: true

json.data resources do |genre|
  json.extract! genre, :id, :name
end
