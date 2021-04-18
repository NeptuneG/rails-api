# frozen_string_literal: true

module Api
  module V1
    class ArtistsController < ApplicationController
      private

      def resource
        Artist.friendly.find(params[:slug])
      end

      def cursor_column
        :slug
      end
    end
  end
end
