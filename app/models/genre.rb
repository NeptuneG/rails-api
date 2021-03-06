# frozen_string_literal: true

class Genre < ApplicationRecord
  has_many :albums, dependent: :restrict_with_exception

  validates :name, presence: true, length: { maximum: 64 }
end
