# frozen_string_literal: true

class LiveEvent < ApplicationRecord
  belongs_to :live_house

  validates :title, :stage_one_start_at, presence: true
  validates :url, uniqueness: true, presence: true
end
