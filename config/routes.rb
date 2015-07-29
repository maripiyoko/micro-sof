Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  concern :voting do
    member do
      post 'up', controller: :votes, action: :up
      delete 'down', controller: :votes, action: :down
    end
  end

  resources :questions, concerns: :voting do
    resources :comments, only: [ :new, :edit, :create, :update, :destroy ]
    resources :answers, concerns: :voting, only: [ :create, :update, :destroy ] do
      member do
        patch :approve
      end
      resources :comments, only: [ :new, :edit, :create, :update, :destroy ]
    end
  end

  resources :tags, only: [ :index, :show ]

  get '/markdown_preview', to: "markdown_preview#preview"
end
