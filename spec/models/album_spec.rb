# frozen_string_literal: true

require 'rails_helper'

describe Album, type: :model do
  it { is_expected.to belong_to(:genre) }
  it { is_expected.to belong_to(:artist) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(255) }
end
