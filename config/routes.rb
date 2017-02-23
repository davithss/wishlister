Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

      root 'home#index'
      get 'wishlist', to: "home#wishlist"
      get 'list', to: "home#add_list_item"
      get 'list_info',  to: "home#list_info"
      get 'delete_item', to: "home#delete_list_item"
      get 'checkins', to: "home#checkins"
      # get '/home/lists', to: "home#lists"
      # get 'index', to: "home#index"

  get 'find', to: 'find#index'
end
