Iformtester::Application.routes.draw do

  resources :iform_xml_feeds, :only => [:index, :create, :show]
  
  resources :iform_xml_posts, :only => [:index, :create, :show]
  
  resources :iform_tests, :only => [:show] do
  
    resources :iform_test_responses, :only => [:index, :create, :show, :destroy]
    
  end
  
  match 'update_feed_from' => 'iform_xml_feeds#update_feed_from', :as => :update_feed_from
  
  match 'update_postxml_key' => 'iform_xml_posts#update_postxml_key', :as => :update_postxml_key
  
  match 'update_sent_to' => 'iform_test_responses#update_sent_to', :as => :update_sent_to
          
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
