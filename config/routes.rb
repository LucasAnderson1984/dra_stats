# frozen_string_literal: true
Rails.application.routes.draw do
  resources :teachers, except: %i(new edit destroy)
end
