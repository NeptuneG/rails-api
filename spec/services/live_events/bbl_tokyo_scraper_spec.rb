# frozen_string_literal: true

require 'rails_helper'

describe LiveEvents::BblTokyoScraper do # rubocop:disable RSpec/EmptyExampleGroup
  subject(:scrape) { described_class.new(year_month).call }

  let(:year_month) { '202011' }

  before { create(:live_house, :bbl_tokyo) }

  # it { scrape }
end
