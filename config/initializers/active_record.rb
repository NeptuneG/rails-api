# frozen_string_literal: true

ActiveRecord::Base.logger = Logger.new('log/sql.log') if Rails.env.development? || Rails.env.test?
