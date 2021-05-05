# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :genres, only: :index
      resources :artists, param: :slug do
        resources :albums, only: :index
      end
      resources :albums
      resources :jobs, param: :jid, except: :update
    end
  end
end
