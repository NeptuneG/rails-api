# frozen_string_literal: true

class CursorPaginator
  class InvalidCursor < StandardError; end
  class InvalidCursorColumn < StandardError; end
  class InvalidSize < StandardError; end

  PER_PAGE_DEFAULT = 20
  PER_PAGE_MIN = 1
  PER_PAGE_MAX = 100

  def initialize(scope, request, cursor_column: :id)
    @scope = scope
    @request = request
    @params = request.params
    @cursor_column = cursor_column
  end

  def call
    validate_params
    validate_cursor_column

    {
      data: data,
      meta: meta
    }
  end

  private

  attr_reader :cursor_column, :params, :request, :scope

  def validate_params
    raise InvalidCursor unless params_valid?
    raise InvalidSize unless size_valid?
  end

  def params_valid?
    params[:starting_after] && params[:ending_before] ? false : true
  end

  def size_valid?
    size >= PER_PAGE_MIN && size <= PER_PAGE_MAX
  end

  def validate_cursor_column
    raise InvalidCursorColumn unless scope.model.column_names.include?(cursor_column.to_s)
    # TODO: validate unique and sequential
  end

  def cursor
    Base64.urlsafe_decode64(params[:starting_after] || params[:ending_before] || '')
  rescue ArgumentError
    raise InvalidCursor
  end

  def size
    @size ||= params[:size].present? ? Integer(params[:size]) : PER_PAGE_DEFAULT
  rescue ArgumentError
    raise InvalidSize
  end

  def direction
    @direction ||= params[:ending_before] ? :ending_before : :starting_after
  end

  def raw_data
    return scope.limit(size + 1) if cursor.blank?

    query = "#{cursor_column} #{direction == :starting_after ? '>' : '<'} ?"
    scope.where(query, cursor)
         .order(cursor_column => direction == :starting_after ? :asc : :desc)
         .limit(size + 1)
  end

  def data
    more? ? raw_data[0...-1] : raw_data
  end

  def more?
    @more ||= raw_data.size == size + 1
  end

  def next_page
    return unless more?

    token = Base64.urlsafe_encode64(data.last[cursor_column].to_s)
    query_params = request.query_parameters.merge({ direction => token })
    "#{request.path}?#{query_params.to_query}"
  end

  def meta
    {
      next_page: next_page
    }
  end
end
