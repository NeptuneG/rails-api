# frozen_string_literal: true

class Asset < ApplicationRecord
  include Indexable

  belongs_to :genre

  validates :title, presence: true, length: { maximum: 128 }
end
