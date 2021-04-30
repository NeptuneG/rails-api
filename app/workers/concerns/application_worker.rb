# frozen_string_literal: true

module ApplicationWorker
  extend ActiveSupport::Concern

  include Sidekiq::Worker
  include Sidekiq::Status::Worker
end
