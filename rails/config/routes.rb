Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :elastic_indexable do
    get 'indexed'
  end

  resources :people, concerns: [:elastic_indexable]

  namespace :config do
    resources :types, only: [:index]
  end
end
