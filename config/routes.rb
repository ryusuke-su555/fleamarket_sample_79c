Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root "front#index"

  resources :front do
    member do
      get 'products'
    end
  end

  resources :products, except: :show do
    resources :purchase do
      member do
        get "index"
        post "create"
      end
    end
  end

  resources :purchase do
    collection do
      get 'complete'
    end

    member do
      post 'products'
    end
  end

  resources :card, only: [:new, :create, :destory, :show] do
    collection do
      delete 'destroy'
      post 'new'
      get 'complete'
    end
  end

  resources :users, only: :show
  resources :detail
  resources :comments
  resources :products, only: [:create,:edit,:destroy,:new,:update]
  resources :complete, only: [:index]
  

  get 'glances/index'
  get 'detail/index'
  get 'comments/index'
  get 'complete/index'
  post 'card/new'
  get 'card/new'
  get 'card/show'
  get 'products/new'
  get 'products/create'
  post "products/:id/update" => "products#update"
  post "products/:id/destroy" => "products#destroy"

  resources :products do
    resources :comments,  only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    collection do
      get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
      get 'post_done'
      get 'delete_done'
      get 'detail_search'
      get 'update_done'
    end
  end
end


