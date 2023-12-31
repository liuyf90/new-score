Rails.application.routes.draw do
  root to: 'projects#index'

  devise_for :users, controllers: {
    sessions: "users",        # 自定义的会话控制器
    registrations: "registrations",    # 自定义的注册控制器
    passwords: "passwords"             # 自定义的密码重置控制器
  } 

  

  resources :projects
  resources :tasks do
    member do
      patch :do_next_step
      patch :do_back_step
      patch :cancel
      # get :available_list
    end
    collection do
      get :available_list
    end
  end
  resources :types
  resources :staffs do
    member do
      patch :enable
      patch :disable
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
