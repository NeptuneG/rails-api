# frozen_string_literal: true

class JobBuilder
  def initialize(jid)
    @jid = jid
  end

  def call
    Job.new(attributes)
  end

  private

  attr_reader :jid

  def attributes
    status_attributes.merge case status['status']
                            when 'failed'
                              failure_attributes
                            when 'working'
                              payload_attributes
                            else
                              {}
                            end
  end

  def status_attributes
    {
      jid: status['jid'],
      type: type(status['worker']),
      args: status['args'],
      status: status['status'],
      updated_at: Time.zone.at(status['update_time'].to_i)
    }
  end

  def failure_attributes
    failure = Redis.current.zscan('sidekiq:failed', 0, match: "*\"jid\":\"#{jid}\"*").last.first.first
    failure_hash = JSON.parse(failure)
    {
      error_message: failure_hash['error_message'],
      created_at: Time.zone.at(failure_hash['created_at']),
      updated_at: Time.zone.at(failure_hash['failed_at']),
      enqueued_at: Time.zone.at(failure_hash['enqueued_at'])
    }
  end

  def payload_attributes
    payload = Sidekiq::Workers.new.find { |_pid, _tid, work| work['payload']['jid'] == jid }.last.fetch('payload')
    {
      created_at: Time.zone.at(payload['created_at']),
      enqueued_at: Time.zone.at(payload['enqueued_at'])
    }
  end

  def type(worker_class_name)
    worker_class_name.gsub(/Worker$/, '').underscore
  end

  def status
    @status ||= begin
      status = Sidekiq::Status.get_all(jid)
      raise ActiveRecord::RecordNotFound if status.blank?

      status
    end
  end
end
