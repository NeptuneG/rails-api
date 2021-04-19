# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include ErrorHandler

      def index
        render locals: CursorPaginator.new(resources, request, cursor_column: cursor_column).call
      end

      def show
        render locals: { resource: resource }
      end

      def create
        render :show, locals: { resource: model.create!(resource_params) }, status: :created
      end

      def update
        update_resource = resource
        update_resource.update!(resource_params)
        render :show, locals: { resource: update_resource }
      end

      def destroy
        resource.destroy!
      end

      private

      def model_name
        controller_path.split('/').last.classify
      end

      def model
        model_name.constantize
      end

      def model_symbol
        model_name.underscore.to_sym
      end

      def permitted_attributes
        model.column_names.map(&:to_sym) - %i[id created_at updated_at]
      end

      def resource
        model.find(params[:id])
      end

      def resources
        model.all
      end

      def resource_params
        params.require(model_symbol).permit(permitted_attributes)
      end

      def cursor_column
        :id
      end
    end
  end
end
