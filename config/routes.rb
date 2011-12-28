TasteBuddy::Application.routes.draw do
  resources :menu_items, controller: 'restaurant/menu/items'
  resources :restaurant_menu_items, controller: 'restaurant/menu/items'
  resources :restaurant_groups, controller: 'restaurant/groups'
  # resources :restaurant_menu_item_comments, controller: 'restaurant/menu/item/comments', only: :create

  match 'search' => 'search#new', :via => :get
  match 'search' => 'search#show', :via => :post
  match 'complete' => 'autocompletes#new', :via => :get
  match 'complete' => 'autocompletes#show', :via => :post

  resources :restaurants do
    resources :groups
  end
  match 'restaurants/:id/menu' => 'restaurant/menus#show', via: :get, as: :restaurant_menu
  match 'restaurants/:id/menus/grubhub' => 'restaurant/menus#grubhub', via: :get, as: :restaurant_grubhub_menu
  match 'restaurants/:id/menus/menupages' => 'restaurant/menus#menupages', via: :get, as: :restaurant_menupages_menu
  match 'restaurants/:id/bookmark' => 'restaurant/bookmarks#create', :via => [:post, :put]
  match 'restaurants/:id/bookmark' => 'restaurant/bookmarks#destroy', :via => :delete
  match 'restaurants/:id/rate' => 'restaurant/ratings#create', :via => [:post, :put]
  match 'restaurants/:id/tag' => 'restaurant/tags#create', :via => [:post, :put]
  match 'restaurants/:id/tag' => 'restaurant/tags#destroy', :via => :delete
  match 'restaurants/:id/comment' => 'restaurant/comments#create', :via => [:post, :put], as: :restaurant_comments

  match 'menu_items/:id/bookmark' => 'restaurant/menu/item/bookmarks#create', :via => [:post, :put]
  match 'menu_items/:id/bookmark' => 'restaurant/menu/item/bookmarks#destroy', :via => :delete
  match 'menu_items/:id/rate' => 'restaurant/menu/item/ratings#create', :via => [:post, :put], as: :restaurant_menu_item_ratings
  match 'menu_items/:id/tag' => 'restaurant/menu/item/tags#create', :via => [:post, :put]
  match 'menu_items/:id/tag' => 'restaurant/menu/item/tags#destroy', :via => :delete
  match 'menu_items/:id/comment' => 'restaurant/menu/item/comments#create', :via => [:post, :put], as: :restaurant_menu_item_comments

  match 'tags' => 'authorized_tags#tag_names', as: :authorized_tag_names

  resources :festivals
  resources :pictures

  devise_for :users
  match 'users/update' => 'user/attributes#update', :via => :put
  match 'users/profile' => 'user/attributes#profile', :via => :get
  match 'users/bookmarks' => 'user/attributes#bookmarks', :via => :get

  resources :eugene_caches, only: [:index, :create]

  root to: 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
