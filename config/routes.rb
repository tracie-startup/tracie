Rails.application.routes.draw do
  devise_for :users
  resources :beta_requests

  resources :agile_pois
  get 'app' => 'agile_pois#map', :as => :app

  offline = Rack::Offline.configure do
    #   #cache ActionController::Base.helpers.asset_path("header-map.png")
    cache ActionController::Base.helpers.asset_path("application.css")
    cache ActionController::Base.helpers.asset_path("application.js")
    cache ActionController::Base.helpers.asset_path("agile_pois.js")
    cache ActionController::Base.helpers.asset_path("preview-map.png")
    #cache ActionController::Base.helpers.font_path("glyphicons-halflings-regular.ttf")
    cache "https://api.tiles.mapbox.com/mapbox.js/v2.1.4/mapbox.js"
    cache "https://api.tiles.mapbox.com/mapbox.js/v2.1.4/mapbox.css"
    cache "https://api.tiles.mapbox.com/mapbox.js/v2.1.4/images/icons-000000@2x.png"
    network "*"
  end
  get "/application.manifest" => offline

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'landingpage#index'
  get 'impressum' => 'landingpage#impressum'
  get 'datenschutz' => 'landingpage#datenschutz'
  get 'details' => 'landingpage#details'

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
