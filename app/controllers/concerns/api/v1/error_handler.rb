# frozen_string_literal: true

module Api
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern

      INTERNAL_ERROR = { code: 9999, error_msg: 'Unknown system error.' }.freeze
      RESOURCE_NOT_FOUND = { code: 1001, error_msg: 'Resource is not found.' }.freeze
      INVALID_CURSOR_TOKEN = { code: 2001, error_msg: 'Unrecognized cursor token.' }.freeze
      INVALID_CURSOR_SIZE = {
        code: 2002,
        error_msg: "Size of a page must be greater or equal than #{CursorPaginator::PER_PAGE_MIN} " \
                   "and less or equal then #{CursorPaginator::PER_PAGE_MAX}."
      }.freeze
      TOO_MANY_REQUESTS = { code: 8001, error_msg: 'Too many requests. Please retry later.' }.freeze

      ERRORS = [
        # format: [exception_class, http_status, error]
        [StandardError, :internal_server_error, INTERNAL_ERROR],
        [ActiveRecord::RecordNotFound, :not_found, RESOURCE_NOT_FOUND],
        [CursorPaginator::InvalidCursor, :bad_request, INVALID_CURSOR_TOKEN],
        [CursorPaginator::InvalidSize, :bad_request, INVALID_CURSOR_SIZE]
      ].freeze

      included do
        private

        ERRORS.each do |exception_class, status, error|
          handler = define_method("rescue_#{exception_class.name.demodulize.underscore}") do |exception|
            Rails.logger.error(exception.message)
            render_error(status, error)
          end
          rescue_from exception_class, with: handler
        end

        rescue_from ActiveRecord::RecordInvalid, with: :rescue_record_invalid

        def render_error(status, error)
          render 'api/v1/shared/errors/index', status: status, locals: error
        end

        def rescue_record_invalid(exception)
          render_error(:unprocessable_entity, { code: 1002, error_msg: exception.message })
        end
      end
    end
  end
end
