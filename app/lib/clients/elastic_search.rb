# frozen_string_literal: true

module Clients
  class ElasticSearch
    class << self
      def client
        @client ||= ::Elasticsearch::Client.new(
          url: config[:url],
          log: config[:log],
          timeout: config[:timeout]
        )
      end

      private

      def config
        @config ||= Rails.application.config_for(:elastic_search)
                         .deep_symbolize_keys
      end
    end
  end
end
