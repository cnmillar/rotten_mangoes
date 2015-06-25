RottenMangues::Application.routes.draw do

  get "movies/search", to: 'movies#search'
  # get "users/profiles", to: 'users#profiles', as: 'users_profiles'
  # get "users/:id/profile", to: 'users#show'
  get "admin/switch-to-user/:user_id", to: 'admin/users#switch_user'
  post "admin/switch-to-user/:user_id", to: 'admin/users#switch_user', as: 'admin_switch_user'
  post "admin/switch-back/:user_id", to: 'admin/users#switch_back', as: 'admin_switch_back'
  get "admin/switch-back/:user_id", to: 'admin/users#switch_back'


  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  
  resources :users, only: [:new, :create, :index, :show]

  namespace :admin do
    resources :users
    resources :movies, only: [:destroy]
  end

  resource :session, only: [:new, :create, :destroy]
  
  root to: 'movies#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
