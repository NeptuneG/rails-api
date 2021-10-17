# frozen_string_literal: true

class FoobarWorker
  include ApplicationWorker

  sidekiq_options queue: :scheduled_jobs, retry: false

  def perform
    now = Time.zone.now.strftime('%Y%m%d_%H:%M:%S')
    Artist.create!(name: "Foobar Artist #{now}", description: 'dummy')
  end
end
