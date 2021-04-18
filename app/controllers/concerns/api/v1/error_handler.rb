# frozen_string_literal: true

module Api
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern

      ERRORS = [
        # format: [exception_class, http_status, { code: 0000, error_msg: 'error'}]
        [StandardError, :internal_server_error, { code: 9999, error_msg: 'Unknown system error' }],
        [ActiveRecord::RecordNotFound, :not_found, { code: 1001, error_msg: 'Resource is not found' }],
        [CursorPaginator::InvalidCursor, :bad_request, { code: 2001, error_msg: 'Unrecognized cursor token' }],
        [CursorPaginator::InvalidSize, :bad_request, {
          code: 2002,
          error_msg: "Size of a page must be greater or equal than #{CursorPaginator::PER_PAGE_MIN} " \
                     "and less or equal then #{CursorPaginator::PER_PAGE_MAX}"
        }]
      ].freeze

      included do
        private

        ERRORS.each do |exception, status, error|
          handler = define_method "rescue_#{exception.name.demodulize.underscore}" do
            render_error(status, error)
          end
          rescue_from exception, with: handler
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
