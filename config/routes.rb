Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  concern :voting do
    member do
      post 'up', controller: :votes, action: :up
      delete 'down', controller: :votes, action: :down
    end
  end

  concern :commentable do
    resources :comments, only: [ :create, :update, :destroy ]
  end

  resources :questions, concerns: [ :voting, :commentable ] do
    resources :answers, concerns: [ :voting, :commentable ], only: [ :create, :update, :destroy ]
  end

end
