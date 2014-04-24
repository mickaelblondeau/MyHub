MyHub::Application.routes.draw do

  scope '(:locale)', locale: /fr|en/ do
    devise_for :users
    resources :welcome, :only => [:index]
    resources :channels, :only => [:index, :create, :destroy, :show, :update]
    resources :videos, :only => [:create, :destroy, :show]
    resources :playlists, :only => [:index, :create, :destroy, :show], :path  => 'series'
    resources :participations, :only => [:create, :destroy]
    resources :users, :only => [:show]
    resources :comments, :only => [:create, :destroy]
    resources :likes, :only => [:create, :destroy]
    resources :votes, :only => [:create, :destroy]
    resources :articles, :only => [:create, :destroy]
    resources :cooperation_permissions, :only => [:create, :destroy, :show]
    resources :cooperations, :only => [:create, :destroy, :show]
    root 'welcome#index'
  end

end