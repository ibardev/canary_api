Rails.application.routes.draw do

  get 'agreement' => 'agreement#index'

  get 'home/index'

  root 'home#index'

  get "home/:id" => 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  ######################################################
  # SMS Routes
  resources :sms_tokens, only:[:show]  do
    collection do
      post 'register'
    end
  end
  ######################################################

  ######################################################
  # User Routes
  devise_for :users

  resource :user_info, only: [:show, :update] do
    collection do
      post 'check'
      post 'reset'
    end
  end

  resources :friends, only: [:index, :show] do
    member do
      post 'follow'
      post 'collect'
      post 'uncollect'
      post 'info'
      post 'like'
      resources :complains, only: [:create]
    end
    collection do
      get 'collected'
      get 'followed'
      get 'followings'
      get 'local'
      get 'foreign'
      get 'count'
      get 'liked'
      get 'responders'
    end
  end

  resources :complains, only: [:show]

  resources :banners, only: [:index]

  ######################################################

  ######################################################
  # Discover Routes
  resources :invite_discovers, only: [:show, :create, :destroy] do
    member do
      post 'respond'
      post 'unrespond'
    end
  end
  resources :discovers, only: [:index]

  ######################################################  

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
