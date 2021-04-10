# frozen_string_literal: true

class Album < ApplicationRecord
  include Searchable

  belongs_to :artist
  belongs_to :genre

  validates :title, presence: true, length: { maximum: 255 }
end
