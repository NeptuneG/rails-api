# frozen_string_literal: true

json.extract! resource, :jid, :type
json.args JSON.parse(resource.args.presence || '[]')
json.extract! resource, :status, :error_message, :created_at, :updated_at, :enqueued_at
