# frozen_string_literal: true

class CreateLiveEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :live_events do |t|
      t.string :title, null: false
      t.string :url, null: false, index: { unique: true }
      t.text :description
      t.string :price_info
      t.datetime :stage_one_open_at
      t.datetime :stage_one_start_at, null: false
      t.datetime :stage_two_open_at
      t.datetime :stage_two_start_at
      t.references :live_house, null: false, foreign_key: true

      t.timestamps
    end
  end
end
