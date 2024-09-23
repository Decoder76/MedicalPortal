Rails.application.routes.draw do
  get "doctors/index"
  resources :patients, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  devise_for :users

  authenticated :user, ->(u) { u.doctor? } do
      get 'doctor_portal', to: 'doctors#index'
    end

  authenticated :user, ->(u) { u.receptionist? } do
    root to: 'patients#index', as: :receptionist_root
  end

  get "up" => "rails/health#show", as: :rails_health_check


  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest


  root to: "home#index"
end
