# frozen_string_literal: true

require 'rails_helper'

describe Job, type: :model do
  # TODO: complete example
  # describe '.all' do
  # end

  describe '.find' do
    subject(:find) { described_class.find(jid) }

    let(:jid) { 'ac96a74aab3efb9c8cf910de' }
    let(:job_builder) { instance_double(JobBuilder, call: build(:job, jid: jid)) }

    before { allow(JobBuilder).to receive(:new).and_return(job_builder) }

    it 'relies on JobBuilder' do
      expect(JobBuilder).to receive(:new).with(jid)
      expect(job_builder).to receive(:call)
      find
    end
  end

  describe '.enqueue' do
    context 'when type is valid' do
      let(:type) { 'live_events_scraping' }
      let(:args) { ['202011'] }

      it 'enqueues the required job with args' do
        expect(LiveEventsScrapingWorker).to receive(:perform_async).with('202011')
        described_class.enqueue(type: type, args: args)
      end
    end

    context 'when type is invalid' do
      let(:type) { 'foobar' }
      let(:args) { [''] }

      it 'raises UnscheduleRunningJob' do
        expect { described_class.enqueue(type: type, args: args) }.to raise_error(Job::UnrecognisedType)
      end
    end
  end

  describe '#unschedule!' do
    let(:job) { build(:job) }

    before { allow(Sidekiq::Status).to receive(:unschedule).and_return(true) }

    it 'relies on Sidekiq::Status.unschedule' do
      expect(Sidekiq::Status).to receive(:unschedule).with(job.jid)
      job.unschedule!
    end

    context 'when the job cannoe be unschedule' do
      before { allow(Sidekiq::Status).to receive(:unschedule).and_return(false) }

      it 'raises UnscheduleRunningJob' do
        expect { job.unschedule! }.to raise_error(Job::UnscheduleRunningJob)
      end
    end
  end
end
