# frozen_string_literal: true

class CreateLiveHouses < ActiveRecord::Migration[6.1]
  def change
    create_table :live_houses do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :address

      t.timestamps
    end
  end
end
