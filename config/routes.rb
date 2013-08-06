Rabotlivko::Application.routes.draw do

  root :to => 'adverts#index'
  resources :adverts

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }, skip: [:registrations, :sessions, :confirmations, :passwords]

  devise_scope :user do
    match 'sign_up'  => 'registrations#create',  as: :user_registration, via: :post
    match 'sign_in'  => 'sessions#create',       as: :user_session, via: :post
    match 'sign_out' => 'devise/sessions#destroy', as: :destroy_user_session, via: :delete
    match 'password'          => 'devise/passwords#create',     via: :post
    match 'confirmation/new'  => 'devise/confirmations#create', via: :post
    match 'confirmation'      => 'devise/confirmations#show',   via: :get
  end

  match '/me', to: 'users#profile_master', as: :user_root
  match '/users/:id', to: 'users#show', as: :user

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
