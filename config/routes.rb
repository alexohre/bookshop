Rails.application.routes.draw do
  # constraints(domain: 'bit.sh') do
  #   get '/:short_code', to: 'urls#redirect', as: :bit_redirect
  # end
    
  namespace :account do

    get 'dashboard', to: 'dashboard#home'
    get 'books', to: 'books#book'
    post 'books', to: 'books#create'
    get 'sales_history', to: 'sales#sales_history'

    # post 'revert_masquerade', to: "dashboard#revert_masquerade"
    # setting
    get 'settings/change_password', to: 'setting#change_password'
    get 'settings/profile', to: 'setting#profile'

  end


  namespace :admin do
    
    resource :site, only: [:new, :create, :edit, :update]
    get 'dashboard', to: 'dashboard#home'

    # config/routes.rb
    resources :stock, only: [:index, :edit, :update]
    resources :sales, only: [:create, :show]
    get 'sales_history', to: 'sales#sales_history'
    get 'bookshop', to: 'sales#home'
    get 'sales/*mat_no', to: 'sales#sales'
    get 'clear', to: 'sales#clear'
    post 'sales/add_to_pending/:book_id', to: 'sales#add_to_pending', as: 'add_to_pending'
    delete 'sales/remove_from_pending/:book_id', to: 'sales#remove_from_pending', as: 'remove_from_pending'
  
    get 'students', to: 'dashboard#students'
    get 'new_student', to: 'dashboard#new_student'
    get 'users/:id', to: 'dashboard#show'

    resources :students, only: [:new, :create] do
      collection { post :import }
    end

    get 'staffs', to: 'staffs#index'
    post 'staffs', to: 'staffs#create'
    # post 'masquerade_as_account', to: 'dashboard#masquerade_as_account'
    # delete account
    delete 'users/:id', to: 'dashboard#destroy'
    # mails
    get 'emails', to: 'email#sent'
    get 'email/new', to: 'email#new'
    post 'emails', to: 'email#create'
        # settings
    get 'settings/account', to: 'setting#account'
    get 'settings/password', to: 'setting#admin_password'
    get 'settings/site_details', to: 'setting#site_details'

    resources :room_types
    resources :rooms
  end

  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations',
    passwords: 'accounts/passwords',
    confirmations: 'accounts/confirmations'
    }, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    registration: 'students',
    sign_up: 'sign_up'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    }, path: 'admin', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: 'user',
    sign_up: 'sign_up'
  }

  root 'pages#home'

  post '/fetch_title', to: 'title_fetcher#fetch_title'
end
