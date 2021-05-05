# frozen_string_literal: true

module Api
  module V1
    class JobsController < ApplicationController
      def index
        render locals: { data: Job.all }
      end

      def create
        jid = Job.enqueue(type: params[:type], args: params[:args])
        render json: { jid: jid, meta: { self: api_v1_job_path(jid: jid) } },
               status: :accepted, location: api_v1_job_url(jid: jid)
      end

      def destroy
        resource.unschedule!
      end

      private

      def resource
        Job.find(params[:jid])
      end
    end
  end
end
