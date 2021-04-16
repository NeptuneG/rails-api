# frozen_string_literal: true

module Api
  module V1
    class AlbumsController < ApplicationController
      private

      def resources
        return Album.all if params[:artist_slug].blank?

        artist = Artist.friendly.find(params[:artist_slug])
        Album.where(artist: artist)
      end
    end
  end
end
