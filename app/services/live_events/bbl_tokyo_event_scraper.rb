# frozen_string_literal: true

module LiveEvents
  class BblTokyoEventScraper
    def initialize(live_event_url)
      @live_event_url = live_event_url
    end

    def call
      LiveEvent.new(
        live_house_id: live_house_id, url: live_event_url,
        title: scrape_title, description: scrape_description, price_info: scrape_price_info,
        stage_one_open_at: "#{scrape_date} #{scrape_open_starts[0]}",
        stage_one_start_at: "#{scrape_date} #{scrape_open_starts[1]}",
        stage_two_open_at: "#{scrape_date} #{scrape_open_starts[2]}",
        stage_two_start_at: "#{scrape_date} #{scrape_open_starts[3]}"
      )
    end

    private

    attr_reader :live_event_url

    def live_house_id
      @live_house_id ||= LiveHouse.find_by(name: 'Billboard Live TOKYO').id
    end

    def scrape_title
      Helpers.trim(parsed_live_event_page.css('div.lf_area_liveinfo h3.lf_tokyo').first.text)
    end

    def scrape_description
      Helpers.trim(parsed_live_event_page.css('div.lf_area_liveinfo p')[2].text, keep_linefeed: true)
    end

    def scrape_price_info
      Helpers.trim(parsed_live_event_page.css('div.lf_txtarea_memberprice').first.parent.css('p').first.text)
    end

    def scrape_date
      @scrape_date ||= parsed_live_event_page.css('div.lf_area_liveinfo div.lf_ttl h3').text[...-3]
    end

    def scrape_open_starts
      @scrape_open_starts ||= Helpers.trim(parsed_live_event_page.css('div.lf_openstart').text)
                                     .split.filter { |word| match_hour_format?(word) }
    end

    def parsed_live_event_page
      @parsed_live_event_page ||= MetaInspector.new(live_event_url).parsed
    end

    def match_hour_format?(timestamp)
      # HH:MM 24-hour with leading 0
      /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/.match?(timestamp)
    end
  end
end
