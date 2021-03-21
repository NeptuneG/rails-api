# frozen_string_literal: true

module Api
  module V1
    module DatabaseHandler
      extend ActiveSupport::Concern

      included do
        before_action :connect_database!
        after_action :disconnect_database!
      end

      private

      def connect_database!
        db_connection_config = ActiveRecord::Base.connection_db_config.clone
        db_connection_config._database = database
        @db_connection = ActiveRecord::Base.establish_connection(db_connection_config)
      end

      def disconnect_database!
        @db_connection.disconnect!
      end

      def database
        @database ||= params.require(:database)
      end

      def model_name
        @model_name ||= controller_path.remove('api/v1/').classify
      end

      def model
        model_name.constantize
      end
    end
  end
end
