# frozen_string_literal: true

json.data data do |job|
  json.extract! job, :jid, :type
  json.args JSON.parse(job.args.presence || '[]')
  json.extract! job, :status, :error_message, :created_at, :updated_at, :enqueued_at
end
