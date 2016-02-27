Rails.application.routes.draw do
  devise_for :dukes, :controllers => { registrations: 'dukes/registrations', sessions: "dukes/sessions" }
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }

  resources :messages
  resources :reviews
  resources :notes
  resources :items

  resources :quests do
    member do
      get 'getmeaquest'
      get 'dotraining'
      get 'submitproposal'
      get 'submitrevisedproposal'
      get 'revisionthanks'
      post 'paybill'
      get 'submitproof'
      get 'releasepayment'
      get 'paycharge'
      get 'paybillreturn'
      get 'flagquest'
      get 'findquest'
      get 'getmyquest'
      get 'moreinfo'
      get 'userquestionnaire'
      get 'dointerview'
      get 'miniquestlist'
      get 'questthanks'
      get 'completed'
      get 'stats'
      get 'proposal'
      get 'completedduke'
      patch 'revision'
    end
  end

  devise_scope :duke do
    get 'dukes/minisignup' => 'dukes/registrations#new'
    get 'dukes/minisignin' => 'devise/sessions#new'
  end

  root 'quests#index'
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
