Rails.application.routes.draw do
  get 'staffs/index'
  

  resources :projects
  resources :staffs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
