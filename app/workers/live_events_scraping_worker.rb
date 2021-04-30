# frozen_string_literal: true

class LiveEventsScrapingWorker
  include ApplicationWorker

  sidekiq_options queue: :live_events, retry: false

  def perform(year_month)
    LiveEvents::BblTokyoScraper.new(year_month).call
  end
end
