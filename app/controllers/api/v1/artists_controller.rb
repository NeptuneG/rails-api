# frozen_string_literal: true

module Api
  module V1
    class ArtistsController < ApplicationController
      def index
        resources = Artist.all

        render locals: { resources: resources }
      end

      def show
        render locals: { resource: resource }
      end

      def create
        resource = Artist.new(resource_params)

        if resource.save
          render :show, locals: { resource: resource }, status: :created, location: api_v1_artist_url(resource)
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end

      def update
        if resource.update(resource_params)
          render :show, locals: { resource: resource }
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end

      def destroy
        resource.destroy!
      end

      private

      def resource
        @resource ||= Artist.friendly.find(params[:slug])
      end

      def resource_params
        params.require(:artist).permit(:name, :description)
      end
    end
  end
end
