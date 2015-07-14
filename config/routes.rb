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
    resources :answers, concerns: :voting, only: [ :create, :update, :destroy ]
  end

  resources :questions do
    resources :comments
  end

  resources :answers do
    resources :comments
  end

end
