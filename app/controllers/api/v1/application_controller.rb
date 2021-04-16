# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::Base
      def index
        render locals: { resources: resources }
      end

      def show
        render locals: { resource: resource }
      end

      def create
        resource = model.new(resource_params)

        if resource.save
          render :show, locals: { resource: resource }, status: :created
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end

      def update
        update_resource = resource
        if update_resource.update(resource_params)
          render :show, locals: { resource: update_resource }
        else
          render json: update_resource.errors, status: :unprocessable_entity
        end
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
    end
  end
end
