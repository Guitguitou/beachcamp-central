Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "design-system", to: "design_system#index",      as: :design_system
  get "design-tokens", to: "design_system#tokens",      as: :design_tokens
  get "style-guide",   to: "design_system#style_guide", as: :style_guide

  scope "/:locale", locale: /en|fr|es|it/ do
    devise_for :users

    root "camps#index", as: :root

    resources :camps, only: [:index, :show] do
      resources :registrations, only: [:create, :destroy], controller: "camp_registrations"
      resources :conversations, only: [:show] do
        resources :messages, only: [:create]
      end
    end

    namespace :coach do
      get "dashboard", to: "dashboard#show"
      resources :camps, only: [:index, :show] do
        resources :registrations, only: [:index, :update], controller: "camp_registrations"
      end
    end

    namespace :player do
      get "dashboard", to: "dashboard#show"
      resources :registrations, only: [:index, :destroy]
    end

    namespace :admin do
      get "dashboard", to: "dashboard#show"
      resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :camps do
        member do
          patch :publish
          patch :cancel
          patch :set_draft
        end
        resources :registrations, only: [:index, :update], controller: "camp_registrations"
      end
    end

    namespace :organizer do
      get "dashboard", to: "dashboard#show"
      resources :camps do
        member do
          patch :publish
          patch :cancel
        end
        resources :registrations, only: [:index, :update], controller: "camp_registrations"
      end
      resources :conversations, only: [:index, :show] do
        resources :messages, only: [:create]
      end
    end
  end

  get "/", to: redirect("/en")
end
