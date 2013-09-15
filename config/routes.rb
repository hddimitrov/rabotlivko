Rabotlivko::Application.routes.draw do
  root :to => 'pages#home'
  match '/about',    to: 'pages#about',    as: :page_about
  match '/faq',      to: 'pages#faq',    as: :page_faq
  match '/contacts', to: 'pages#contacts', as: :page_contacts
  match '/contacts_map', to: 'pages#contacts_map', as: :page_contacts_map
  match '/ask_question', to: 'contacts#ask_question', via: :post
  match '/flag_item', to: 'contacts#flag_item', via: :post

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

  match '/me', to: 'users#profile', as: :user_root

  match '/contractors/:slug', to: 'contractors#show', as: :user
  match '/contractors',     to: 'contractors#index', as: :contractors

  resources :adverts, except: [:edit, :update]
  resources :want_ads, except: [:edit, :update]

  scope 'api' do
    scope 'advert' do
      match 'fav',   to: 'favorites#fav_advert', via: :post
      match 'unfav', to: 'favorites#unfav_advert', via: :post
      match 'update',to: 'want_ads#update', via: :post
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
      match 'become_contractor', to: 'users#become_contractor', via: :post,  as: :become_contractor
    end

    scope 'filter' do
      match 'adverts', to: 'adverts#filter', via: :post
      match 'want_ads', to: 'want_ads#filter', via: :post
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
