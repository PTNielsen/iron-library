Rails.application.routes.draw do
  devise_for :users
  resources :books

  root "books#index"

  patch "/books/:id/checkout" => "books#checkout"
end