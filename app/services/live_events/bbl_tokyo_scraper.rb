# frozen_string_literal: true

module LiveEvents
  class BblTokyoScraper
    def initialize(year_month)
      @year_month = year_month
    end

    def call
      scrape_live_events
      validate_scraped_live_events
      log_invalid_live_events
      save_scraped_live_events
    end

    private

    def scrape_live_events
      @live_events = Parallel.map(live_event_urls, in_threads: 20) { |url| scrape_event(url) }
    end

    def validate_scraped_live_events
      @valid_live_events, @invalid_live_events = @live_events.partition(&:valid?)
    end

    def log_invalid_live_events
      @invalid_live_events.each do |event|
        err_msg = "LiveEvent: #{event.attributes} - #{event.errors.full_messages}"
        Rails.logger.warn(err_msg)
      end
    end

    def save_scraped_live_events
      LiveEvent.import(@valid_live_events)
    end

    def live_event_urls
      schedule_page.links.all.filter { |url| live_event_url?(url) }
    end

    def schedule_page
      MetaInspector.new(year_month_url)
    end

    def year_month_url
      home_page_url = 'http://www.billboard-live.com/pg/shop/show/index.php'
      params = { date: @year_month, mode: :calendar, shop: 1 }
      "#{home_page_url}?#{params.to_param}"
    end

    def live_event_url?(url)
      %r{http://www.billboard-live.com/pg/shop/show/index.php\?mode=\w+&event=\d+&shop=1$}.match?(url)
    end

    def scrape_event(live_event_url)
      BblTokyoEventScraper.new(live_event_url).call
    end
  end
end
