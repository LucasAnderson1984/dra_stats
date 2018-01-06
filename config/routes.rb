# frozen_string_literal: true

Rails.application.routes.draw do
  resources :dra_score_students, except: %i(new edit)
  resources :dra_scores, except: %i(new edit)
  resources :students, except: %i(new edit destroy)

  resources :teachers, except: %i(new edit destroy) do
    resources :students, only: %i(index show)
  end
end
