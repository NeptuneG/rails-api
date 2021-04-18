# frozen_string_literal: true

unless Rails.env.test?
  Elasticsearch::Model.client = Elasticsearch::Client.new(
    Rails.application.config_for(:elastic_search)
  )
end
