Rails.application.routes.draw do
  root "users#index"

  resources :users do
    member do
      post :rescan
    end
  end
end
