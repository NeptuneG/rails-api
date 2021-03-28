# frozen_string_literal: true

Elasticsearch::Model.client = Clients::ElasticSearch.client unless Rails.env.test?
