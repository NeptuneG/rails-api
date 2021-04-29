# frozen_string_literal: true

require 'rails_helper'

describe LiveHouse, type: :model do
  it { is_expected.to have_many(:live_events) }
  it { is_expected.to validate_presence_of(:name) }
  it { expect(create(:live_house)).to validate_uniqueness_of(:name) }
end
