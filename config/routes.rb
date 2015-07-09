Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  concern :voting do
    member do
      post 'vote_up', controller: :votes, action: :up
      delete 'vote_down', controller: :votes, action: :down
    end
  end

  resources :questions, concerns: :voting do
    resources :answers, concerns: :voting, only: [ :create, :update, :destroy ]
  end

end
