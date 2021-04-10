# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks unless Rails.env.test?

    document_type table_name
    index_name    Rails.env
  end
end
