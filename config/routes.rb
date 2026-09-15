Rails.application.routes.draw do

  root "pages#home"
  get "/visiting", to: "pages#visiting", as: :visiting
  get "/about", to: "pages#about", as: :about

  resources :customers, only: [:index, :show]
  resources :bikes, only: [:index, :show]
  resources :repairs, only: [:index, :show]
  resources :employees, only: [:index, :show]
  resources :standard_services, only: [:index, :show], path: 'services'

end
