Rails.application.routes.draw do
  get 'braintree/new'
  post '/braintree/new' => "braintree#checkout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#index"

  get 'tags/:tag' => 'welcome#index', as: :tag
  get '/search' => 'listings#autocomplete', as: :search_autocomplete

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :users, except: [:create, :new] do
    resources :listings
    resources :reservations, only: [:index]
  end

  resources :listings, only: [] do
    resources :reservations
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
