Rabotlivko::Application.routes.draw do
  root :to => 'pages#home'

  resources :adverts

  resources :want_ads

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }, skip: [:registrations, :sessions, :confirmations, :passwords]
  ActiveAdmin.routes(self)

  devise_scope :user do
    match 'sign_up'           => 'registrations#create',  as: :user_registration, via: :post
    match 'sign_in'           => 'sessions#create',       as: :user_session, via: :post
    match 'sign_out'          => 'devise/sessions#destroy', as: :destroy_user_session, via: :delete
    match 'password'          => 'devise/passwords#create',     via: :post
    match 'confirmation/new'  => 'confirmations#create', via: :post, as: :resend_confirmation
    match 'confirmation'      => 'devise/confirmations#show',   via: :get, as: :confirmation
  end

  match '/me', to: 'users#profile_master', as: :user_root
  match '/users/:id', to: 'users#show', as: :user
  match '/contractors', to: 'users#contractors_index', as: :contractors
  match '/user/become_contractor', to: 'users#become_contractor', via: :post,  as: :become_contractor

  scope 'api' do
    scope 'advert' do
      match 'fav',   to: 'favorites#fav_advert', via: :post
      match 'unfav', to: 'favorites#unfav_advert', via: :post
    end

    scope 'want_ad' do
      match 'fav',   to: 'favorites#fav_want_ad', via: :post
      match 'unfav', to: 'favorites#unfav_want_ad', via: :post
      match 'update',to: 'want_ads#update', via: :post
    end

    scope 'job' do
      match 'applicant_manage_want_ad_job' => 'jobs#applicant_manage_want_ad_job', via: :post
      match 'applicant_manage_advert_job'  => 'jobs#applicant_manage_advert_job', via: :post
      match 'owner_manage_job'             => 'jobs#owner_manage_job', via: :post
    end

    scope 'user' do
      match 'fav',     to: 'favorites#fav_user', via: :post
      match 'unfav',   to: 'favorites#unfav_user', via: :post
      match 'block',   to: 'favorites#block_user', via: :post
      match 'unblock', to: 'favorites#unblock_user', via: :post
      match 'update',  to: 'users#update', via: :post
    end

    scope 'filter' do
      match 'adverts', to: 'adverts#filter', via: :post
      match 'want_ads', to: 'want_ads#filter', via: :post
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
