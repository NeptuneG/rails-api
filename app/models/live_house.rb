# frozen_string_literal: true

class LiveHouse < ApplicationRecord
  has_many :live_events, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
