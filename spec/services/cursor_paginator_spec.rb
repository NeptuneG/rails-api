# frozen_string_literal: true

require 'rails_helper'

describe CursorPaginator do
  subject(:cursor_paginate) do
    described_class.new(scope, request, cursor_column: cursor_column).call
  end

  let(:scope) { Album.all }
  let(:request) { ActionDispatch::Request.new('') }
  let(:params) do
    {
      starting_after: Base64.urlsafe_encode64(cursor.to_s),
      size: size
    }
  end
  let(:cursor) { albums[4].id }
  let(:size) { 10 }
  let(:query_parameters) { params }
  let(:path) { '/albums' }
  let(:cursor_column) { :id }

  let_it_be(:albums) { create_list(:album, CursorPaginator::PER_PAGE_DEFAULT + 10) }

  before do
    allow(request).to receive(:params).and_return(params)
    allow(request).to receive(:query_parameters).and_return(query_parameters)
    allow(request).to receive(:path).and_return(path)
  end

  context 'when has more data' do
    let(:size) { 1 }

    it 'returns the data in the page' do
      expect(cursor_paginate[:data]).to match_array albums[5...6]
    end

    it 'sets next_page as uri of the next page' do
      expect(cursor_paginate[:meta][:next_page])
        .to eq "#{path}?#{params.merge(starting_after: Base64.urlsafe_encode64((cursor + 1).to_s)).to_query}"
    end
  end

  context 'when has no more data' do
    let(:size) { 50 }

    it 'returns the data in the page' do
      expect(cursor_paginate[:data]).to match_array albums[5...]
    end

    it 'sets next_page as nil' do
      expect(cursor_paginate[:meta][:next_page]).to be_nil
    end
  end

  context 'when no size is specified in the params' do
    let(:params) do
      {
        starting_after: Base64.urlsafe_encode64(cursor.to_s)
      }
    end
    let(:next_cursor_token) { Base64.urlsafe_encode64((cursor + CursorPaginator::PER_PAGE_DEFAULT).to_s) }

    it 'returns the data in the page' do
      expect(cursor_paginate[:data]).to match_array albums[5...5 + CursorPaginator::PER_PAGE_DEFAULT]
    end

    it 'sets next_page as uri to next page' do
      expect(cursor_paginate[:meta][:next_page])
        .to eq "#{path}?#{params.merge(starting_after: next_cursor_token).to_query}"
    end
  end

  context 'when size is invalid' do
    context 'when size is less than PER_PAGE_MIN' do
      let(:size) { CursorPaginator::PER_PAGE_MIN - 1 }

      it { expect { cursor_paginate }.to raise_error(CursorPaginator::InvalidSize) }
    end

    context 'when size is greater than PER_PAGE_MAX' do
      let(:size) { CursorPaginator::PER_PAGE_MAX + 1 }

      it { expect { cursor_paginate }.to raise_error(CursorPaginator::InvalidSize) }
    end
  end

  context 'when specifies both starting_after and ending_before' do
    let(:params) do
      {
        starting_after: Base64.urlsafe_encode64('5'),
        ending_before: Base64.urlsafe_encode64('8')
      }
    end

    it { expect { cursor_paginate }.to raise_error(CursorPaginator::InvalidCursor) }
  end

  context 'when specifies a cursor_column not belonging to the model of the scope' do
    let(:cursor_column) { :foobar }

    it { expect { cursor_paginate }.to raise_error(CursorPaginator::InvalidCursorColumn) }
  end

  context 'when no cursor or size is specified' do
    let(:params) { {} }
    let(:next_cursor_token) { Base64.urlsafe_encode64(albums[CursorPaginator::PER_PAGE_DEFAULT - 1].id.to_s) }

    it 'returns the data in the first page' do
      expect(cursor_paginate[:data]).to match_array albums[0...CursorPaginator::PER_PAGE_DEFAULT]
    end

    it 'sets next_page as uri of the second page' do
      expect(cursor_paginate[:meta][:next_page])
        .to eq "#{path}?#{params.merge(starting_after: next_cursor_token).to_query}"
    end
  end

  context 'when specifies ending_before' do
    let(:params) do
      {
        ending_before: Base64.urlsafe_encode64(cursor.to_s),
        size: size
      }
    end
    let(:cursor) { albums[4].id }
    let(:size) { 3 }
    let(:next_cursor_token) { Base64.urlsafe_encode64(albums[1].id.to_s) }

    let_it_be(:albums) { create_list(:album, 10) }

    it 'returns the data in the page' do
      expect(cursor_paginate[:data]).to match_array albums[1...4].reverse
    end

    it 'sets next_page as uri of the second page' do
      expect(cursor_paginate[:meta][:next_page])
        .to eq "#{path}?#{params.merge(ending_before: next_cursor_token).to_query}"
    end
  end
end
