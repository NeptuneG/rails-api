# frozen_string_literal: true

require 'swagger_helper'

describe 'api/v1/jobs', type: :request do
  let(:job) { build(:job) }
  let(:jid) { job.jid }

  before { allow(Job).to receive(:find).and_return(job) }

  path '/api/v1/jobs' do
    get('list jobs status') do
      tags 'Jobs'

      response(200, 'successful') do
        before { allow(Job).to receive(:all).and_return([job]) }

        run_test!
      end
    end

    post('enqueue job') do
      tags 'Jobs'
      consumes 'application/json'
      parameter name: :job, in: :body, schema: {
        type: :object,
        properties: {
          type: { type: :string },
          args: {
            type: :array,
            items: { type: :string }
          }
        },
        required: %w[type args]
      }

      response(202, 'job enqueued') do
        before { allow(Job).to receive(:enqueue).and_return(jid) }

        run_test!
      end
    end
  end

  path '/api/v1/jobs/{jid}' do
    parameter name: 'jid', in: :path, type: :string, description: 'jid'

    get('show job status') do
      tags 'Jobs'

      response(200, 'successful') do
        run_test!
      end
    end

    delete('unschedule job') do
      tags 'Jobs'

      response(204, 'job unscheduled') do
        before { allow(job).to receive(:unschedule!) }

        run_test!
      end
    end
  end
end
