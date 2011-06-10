Iformtester::Application.routes.draw do

  resources :iform_xml_feeds
  
  match "show_data_table/:id" => 'iform_xml_feeds#show_data_table'
  
  match "retrieve_iform" => 'iform_xml_feeds#retrieve_iform', :as => :retrieve_iform
  
  match "show_next_steps/:id" => 'iform_xml_feeds#show_next_steps', :as => :show_next_steps
  
  match "show_request/:id" => 'next_steps#show_request', :as => :show_request
  
  match "retrieve_response/:id" => 'next_steps#retrieve_response', :as => :retrieve_response
  
  match "show_response/:id" => 'next_steps#show_response', :as => :show_response
  
  root :to => "iform_xml_feeds#index"
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
