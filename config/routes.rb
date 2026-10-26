Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :registration, only: %i[new create]

  root "pages#home"
  get "/visiting", to: "pages#visiting", as: :visiting
  get "/about", to: "pages#about", as: :about

  resources :customers
  resources :bikes

  resources :repairs do
    member do
      delete :remove_photo
    end
  end

  resources :employees
  resources :standard_services, path: 'services'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :services, only: %i[index show create]
      resources :repairs, only: %i[index show]
    end
  end

end
