Rails.application.routes.draw do

  root to: 'public/homes#top'

  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  # 管理者用
  namespace :admin do
    # top
    get '/' => 'homes#top'
    resources :items, except: [:destroy ]
    resources :genres, only: [:create, :index, :edit, :update ]
    resources :customers, only: [:index, :show, :edit, :update ]
    resources :orders, only: [:show, :update ]
  end

  # 顧客用
  scope module: :public do
    get "/about" => 'homes#about'
    # customers
    get "customers/my_page" => 'customers#show'
    get "customers/infomation/edit" => 'customers#edit'
    patch "customers/infomation" => 'customers#update'
    get "customers/unsubscribe" => 'customers#unsubscribe'
    patch "customers/withdrawl" => 'customers#withdrawl'

    # cart_items
    delete "cart_items/destroy_all" => 'cart_items#destroy_all'

    # orders
    post "orders/confirm" => 'orders#confirm'
    get "orders/confirm" => 'orders#new'
    get "orders/complete" => 'orders#complete'

    resources :items, only: [:index, :show ]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy ]
    resources :cart_items, only: [:index, :create, :update, :destroy ]
    resources :orders, only: [:new, :create, :index, :show ]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
