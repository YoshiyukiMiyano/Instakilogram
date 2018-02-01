Rails.application.routes.draw do

  resources :pictures do
    collection do
      post :confirm
    end
  end

#  resources :feeds

  resources :sessions, only: [:new, :create, :destroy]

  root 'sessions#new'
  
  resources :users, only: [:new, :create, :show]
  
  resources :favorites, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
