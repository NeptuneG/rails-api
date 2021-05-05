# frozen_string_literal: true

require 'rails_helper'

describe '/api/v1/jobs', type: :request do
  let(:valid_headers) { {} }
  let(:job) { build(:job) }
  let(:jid) { job.jid }

  before { allow(Job).to receive(:find).and_return(job) }

  describe 'GET /index' do
    before { allow(Job).to receive(:all).and_return([job]) }

    it 'renders a successful response' do
      get(api_v1_jobs_url, headers: valid_headers, as: :json)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_job_url(jid: jid), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    subject(:enqueue_a_job) do
      post(api_v1_jobs_url, params: attributes, headers: valid_headers, as: :json)
    end

    context 'with valid parameters' do
      let(:attributes) { { type: '', args: ['202111'] } }

      before { allow(Job).to receive(:enqueue).and_return(jid) }

      it 'enqueues the job' do
        expect(Job).to receive(:enqueue).with(type: '', args: ['202111'])
        enqueue_a_job
      end

      it 'renders a JSON response with the new artist' do
        enqueue_a_job
        expect(response).to have_http_status(:accepted)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(response.location).to eq api_v1_job_url(jid: jid)
        expect(response.body).to eq({ jid: jid, meta: { self: api_v1_job_path(jid: jid) } }.to_json)
      end
    end
  end

  describe 'DELETE /destroy' do
    subject(:unschedule_the_job) do
      delete(api_v1_job_url(jid: jid), headers: valid_headers, as: :json)
    end

    it 'unschedule the job' do
      expect(job).to receive(:unschedule!)
      unschedule_the_job
    end
  end
end
