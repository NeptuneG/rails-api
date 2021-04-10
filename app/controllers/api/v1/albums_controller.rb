# frozen_string_literal: true

module Api
  module V1
    class AlbumsController < ApplicationController
      def index
        if params[:artist_slug].present?
          artist = Artist.friendly.find(params[:artist_slug])
          resources = Album.where(artist: artist)
        else
          resources = Album.all
        end

        render locals: { resources: resources }
      end

      def show
        render locals: { resource: resource }
      end

      def create
        resource = Album.new(resource_params)

        if resource.save
          render :show, locals: { resource: resource }, status: :created, location: api_v1_album_url(resource)
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
        @resource ||= Album.find(params[:id])
      end

      def resource_params
        params.require(:album).permit(:title, :description, :release_year, :genre_id, :artist_id)
      end
    end
  end
end
