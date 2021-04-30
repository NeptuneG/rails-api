# frozen_string_literal: true

module LiveEvents
  module Helpers
    def self.trim(text, keep_linefeed: false)
      reg = keep_linefeed ? /[[:space:]&&[^\n]]+/ : /[[:space:]]+/
      text.strip.gsub(reg, ' ')
    end
  end
end
