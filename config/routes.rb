Rails.application.routes.draw do
  root "users#index"

  resources :users do
    post "rescan", on: :member
  end
end
