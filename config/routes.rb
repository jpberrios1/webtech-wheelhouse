Rails.application.routes.draw do

  root "pages#home"
  get "/visiting", to: "pages#visiting", as: :visiting
  get "/about", to: "pages#about", as: :about

  resources :customers
  resources :bikes
  resources :repairs
  resources :employees
  resources :standard_services, path: 'services'

end
