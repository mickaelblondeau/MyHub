MyHub::Application.routes.draw do

  scope '(:locale)', locale: /fr|en/ do
    devise_for :users
    get '/messages/new/:id', to: 'messages#new', as: :new_message_id
    get '/messages/sent', to: 'messages#sent', as: :sent_messages
    get '/messages/recents', to: 'messages#recents', as: :recents_messages
    resources :welcome, :only => [:index]
    resources :search, :only => [:new, :index]
    resources :channels, :only => [:index, :create, :destroy, :show, :update]
    resources :videos, :only => [:create, :destroy, :show, :edit, :update]
    resources :playlists, :only => [:index, :create, :destroy, :show, :edit, :update], :path  => 'series'
    resources :participations, :only => [:create, :destroy]
    resources :users, :only => [:show]
    resources :comments, :only => [:create, :destroy]
    resources :likes, :only => [:create, :destroy]
    resources :votes, :only => [:create, :destroy]
    resources :articles, :only => [:create, :destroy]
    resources :cooperation_permissions, :only => [:create, :destroy, :show]
    resources :video_categories, :only => [:create, :destroy]
    resources :playlist_categories, :only => [:create, :destroy]
    resources :categories, :only => [:index, :show, :create, :destroy, :edit, :update]
    resources :category_links, :only => [:create, :destroy]
    resources :subscription, :only => [:index, :show], :path  => 'subscriptions'
    resources :messages, :only => [:index, :show, :new, :create, :destroy]
    get '/search/(:q)' => 'search#index', as: :query_search
    get '/subscriptions/(:type)/(:slug)' => 'subscription#show', as: :subscription_slug
    root 'welcome#index'
  end

end