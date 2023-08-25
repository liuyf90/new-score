Rails.application.routes.draw do
  root to: 'projects#index'

  devise_for :users, controllers: {
    sessions: "users",        # 自定义的会话控制器
    registrations: "registrations",    # 自定义的注册控制器
    passwords: "passwords"             # 自定义的密码重置控制器
  } 

  

  resources :projects
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
