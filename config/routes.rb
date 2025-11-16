Rails.application.routes.draw do
  resources :member_project_groupings

  get "/members/:id/projects", to: "members#show_projects"

  # show my deadlines that belong to me..
  # aka have a m_id equal to current_member.id
  get "/members/deadlines", to: "members#show_deadlines"

  get "/members/:id/my_project_managers", to: "members#show_my_project_managers"
  get "/members/project_managers", to: "members#show_all_project_managers"

  devise_for :members, controllers: { registrations: "registrations" }

  get "/projects/:id/deadlines/new", to: "deadlines#new"
  post "/projects/:p_id/deadlines/:d_id/apply_deadline_to_members", to: "deadlines#apply_deadline_to_members"
  get "/projects/:p_id/deadlines/:id/", to: "deadlines#show"
  get "/projects/:p_id/deadlines/:d_id/append_member", to: "deadlines#append_member"

  # show this deadline that belongs to THAT project
  get "/projects/:p_id/deadlines/:d_id", to: "deadlines#show"

  resources :deadlines

  get "/projects/:id/show_members", to: "projects#show_members"

  post "/projects/:id/add_members", to: "projects#add_members"
  get "/projects/:id/add_members", to: "projects#add_members"

  post "/projects/:id/delete_members", to: "projects#delete_members"
  get "/projects/:id/remove_members", to: "projects#remove_members"

  resources :projects

  resources :members do
    resources :projects
  end

  get "about", to: "about#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'projects#index'

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
