Rails.application.routes.draw do
  resources :bays do
    get :parked_cars, on: :member
    get :collect_car, on: :member
    get :move_car, on: :member
  end
  resources :cars do
    get :track_all_cars, on: :collection
  end
  root to: "bays#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
