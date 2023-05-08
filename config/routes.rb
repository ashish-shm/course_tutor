# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users

  namespace :api, defaults: { format: :json } do
    resources :courses, only: %i[create index]
  end

end
