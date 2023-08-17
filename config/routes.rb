Rails.application.routes.draw do
  root to: 'projects#index'
  devise_for :users, controllers: { sessions: "users",registrations: "registrations", # 使用自定义的 registrations 控制器 }
  passwords: 'passwords' }# 使用自定义的密码重置控制器

  

  

  resources :projects
  resources :staffs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
