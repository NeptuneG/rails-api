# frozen_string_literal: true

module Api
  module V1
    class AlbumsController < ApplicationController
      before_action :set_album, only: %i[show update destroy]

      def index
        @albums = Album.all

        render json: @albums
      end

      def show
        render json: @album
      end

      def create
        @album = Album.new(album_params)

        if @album.save
          render json: @album, status: :created, location: api_v1_album_url(@album)
        else
          render json: @album.errors, status: :unprocessable_entity
        end
      end

      def update
        if @album.update(album_params)
          render json: @album
        else
          render json: @album.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @album.destroy
      end

      private

      def set_album
        @album = Album.find(params[:id])
      end

      def album_params
        params.require(:album).permit(:title, :description, :genre_id, :artist_id)
      end
    end
  end
end
