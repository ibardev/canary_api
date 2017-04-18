Rails.application.routes.draw do

  resource :wechat, only: [:show, :create]
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
  namespace :wechat do
    resource :session, only: [:create]
  end

  resource :user_info, only: [:show, :update] do
    collection do
      post 'check'
      post 'reset'
      post 'modify'
    end
    resources :pictures, only: [:index, :create] do
      collection do
        post 'delete'
        post 'append'
      end
    end
    resources :messages, only: [:index]
    # resources :discovers, only: [:index]
  end

  resources :friends, only: [:index, :show] do
    resources :pictures, only: [:index]
    resources :complains, only: [:create]
    # resources :discovers, only: [:index]
    member do
      post 'follow'
      post 'collect'
      post 'uncollect'
      post 'info'
      post 'like'
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
      get 'invite_responds'
    end
  end

  get '/user_info/discovers' => 'discovers#user_index'
  get '/friends/:friend_id/discovers' => 'discovers#friend_index'

  resources :complains, only: [:show]

  resources :banners, only: [:index]


  ######################################################

  ######################################################
  # Discover Routes
  resources :invite_discovers, only: [:show, :create, :destroy] do
    member do
      post 'respond'
      post 'unrespond'
      get 'responds'
      post 'append'
    end
    collection do
      get 'validate'
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
