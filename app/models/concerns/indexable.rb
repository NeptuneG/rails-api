# frozen_string_literal: true

module Indexable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    document_type name.underscore.pluralize
    index_name    Rails.env
  end
end
