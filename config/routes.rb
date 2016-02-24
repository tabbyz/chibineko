Rails.application.routes.draw do
  root 'static_pages#top'
  get 'terms' => 'static_pages#terms'
  get 'dashboard' => 'dashboard#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'user_settings/edit'
  patch 'user_settings/update'

  resources :tests, path: 't', param: 'slug', except: ['index'] do
    member do
      get 'move'
      get 'description'
      get 'result_label'
      patch 'update_result_label'
      patch 'user_association'
    end

    resources :testcases, path: 'cases', only: ['update']
  end

  resources :teams, param: 'name', except: ['index'] do
    get 'settings', on: :member

    resources :team_users do
      get 'ajax_search_user', on: :collection
    end

    resources :projects, param: 'project_name', except: ['index'] do
      get 'settings', on: :member
    end
  end
  
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
