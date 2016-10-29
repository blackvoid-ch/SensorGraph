Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sensors#index'

  resources :sensors
  resources :labels
  resources :results

  namespace :api do
    namespace :v1 do
      resources :results
    end
  end

end
