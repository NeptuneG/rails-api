# frozen_string_literal: true

require 'rails_helper'

describe Artist, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(64) }
end
