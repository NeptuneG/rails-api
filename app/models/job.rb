# frozen_string_literal: true

class Job
  include ActiveModel::Model
  include ActiveModel::Attributes

  class UnscheduleRunningJob < StandardError; end
  class UnrecognisedType < StandardError; end

  TYPES_BY_WORKER = { 'live_events_scraping' => LiveEventsScrapingWorker }.freeze

  attribute :jid, :string
  attribute :type, :string
  attribute :status, :string
  attribute :args, :string
  attribute :error_message, :string
  attribute :created_at, :datetime
  attribute :updated_at, :datetime
  attribute :enqueued_at, :datetime

  def self.all
    status_key_prefix = 'sidekiq:sidekiq:status:'
    Redis.current.keys("#{status_key_prefix}*").map do |key|
      jid = key.gsub(status_key_prefix, '')
      find(jid)
    end
  end

  def self.find(jid)
    JobBuilder.new(jid).call
  end

  def self.enqueue(type:, args:)
    raise UnrecognisedType unless TYPES_BY_WORKER.key?(type)

    worker = TYPES_BY_WORKER[type]
    worker.perform_async(*args)
  end

  def unschedule!
    raise UnscheduleRunningJob unless Sidekiq::Status.unschedule(jid)
  end
end
