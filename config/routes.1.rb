Rails.application.routes.draw do
  resources :feeds
  resources :sessions, only: [:new, :create, :destroy]

  root 'webpages#index'
  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  resources :users, only: [:new, :create, :show, :edit, :update]
  
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
