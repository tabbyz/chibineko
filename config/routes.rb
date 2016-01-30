Rails.application.routes.draw do
  root 'static_pages#top'
  get 'dashboard' => 'dashboard#index'

  devise_for :users
  # devise_for :users, controllers: { registrations: "users/registrations" }
  # devise_for :users, controllers: {
    # sessions: 'users/sessions'
  # }
  # get 'users/edit/timezone' => 'users#edit_timezone', as: 'edit_user_timezone'
  # patch 'users/edit/timezone' => 'users#update_timezone', as: 'update_user_timezone'

  # resources :user_settings, only: nil do
  #   collection do
  #     get 'edit'
  #     patch 'update'
  #   end
  # end
  get 'user_settings/edit'
  patch 'user_settings/update'

  resources :tests, path: 't', param: 'slug', except: ['index'] do
    member do
      get 'move'
      get 'description'
      get 'result_label'
      patch 'update_result_label'
    end

    resources :testcases, path: '', param: 'case_id', only: ['update']
  end
  
  resources :teams, param: 'name', path: '', except: ['index'] do
    resources :team_users do
      collection do
        get 'ajax_search_user'
      end
    end
    resources :projects, param: 'project_name', except: ['index']
  end


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
