# frozen_string_literal: true

class Artist < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :albums, dependent: :restrict_with_exception

  validates :name, presence: true, length: { maximum: 64 }

  private

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
