# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :assets
      resources :genres
    end
  end
end
