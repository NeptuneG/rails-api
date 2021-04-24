# frozen_string_literal: true

module Api
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern

      ERRORS = [
        # format: [exception_class, http_status, Error::XXXXX]
        [StandardError, :internal_server_error, Error::INTERNAL_ERROR],
        [ActiveRecord::RecordNotFound, :not_found, Error::RESOURCE_NOT_FOUND],
        [CursorPaginator::InvalidCursor, :bad_request, Error::INVALID_CURSOR_TOKEN],
        [CursorPaginator::InvalidSize, :bad_request, Error::INVALID_CURSOR_SIZE]
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
