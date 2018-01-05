Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'urls#new'
  get "/:short_url", to: "urls#show"

  get "/tokens/generate" => 'tokens#generate',format: :js

  resources :urls

  namespace :api do
    namespace :v1 do
      resources :urls, only: [:create]
    end
  end
end
