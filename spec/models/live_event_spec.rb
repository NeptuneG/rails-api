# frozen_string_literal: true

require 'rails_helper'

describe LiveEvent, type: :model do
  it { is_expected.to belong_to(:live_house) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:stage_one_start_at) }
  it { expect(create(:live_event)).to validate_uniqueness_of(:url) }
end
