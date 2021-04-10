# frozen_string_literal: true

module Api
  module V1
    class GenresController < ApplicationController
      def index
        resources = Genre.all
        render locals: { resources: resources }
      end
    end
  end
end
