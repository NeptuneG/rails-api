# frozen_string_literal: true

module Error
  INTERNAL_ERROR = { code: 9999, error_msg: 'Unknown system error.' }.freeze
  RESOURCE_NOT_FOUND = { code: 1001, error_msg: 'Resource is not found.' }.freeze
  INVALID_CURSOR_TOKEN = { code: 2001, error_msg: 'Unrecognized cursor token.' }.freeze
  INVALID_CURSOR_SIZE = {
    code: 2002,
    error_msg: "Size of a page must be greater or equal than #{CursorPaginator::PER_PAGE_MIN} " \
               "and less or equal then #{CursorPaginator::PER_PAGE_MAX}."
  }.freeze
  TOO_MANY_REQUESTS = { code: 8001, error_msg: 'Too many requests. Please retry later.' }.freeze
end
