Rails.application.routes.draw do

  resources :pictures do
    collection do
      post :confirm
    end
  end

#  resources :feeds

  resources :sessions, only: [:new, :create, :destroy]

#  root 'webpages#index'

  root 'sessions#new'
  
#  resources :blogs do
#    collection do
#      post :confirm
#    end
#  end
  
  resources :users, only: [:new, :create, :show]
  
  resources :favorites, only: [:create, :destroy]
#  resources :favorites do
#    member do
#      post :create
#    end
#  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
