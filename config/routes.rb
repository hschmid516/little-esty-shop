Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/merchants/:merchant_id/dashboard", to: "merchants#dashboard"
end
