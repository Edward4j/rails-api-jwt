Rails.application.routes.draw do
  # mount API::V1::Root => '/'
  mount V1::Root => '/'

  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'

  resources :users, shallow: true do
    resources :tasks
    resources :sub_tasks
  end

  resources :tasks
end
