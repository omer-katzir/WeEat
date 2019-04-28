# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                           restaurants GET    /restaurants(.:format)                                                                   restaurants#index
#                                       POST   /restaurants(.:format)                                                                   restaurants#create
#                            restaurant GET    /restaurants/:id(.:format)                                                               restaurants#show
#                                       PATCH  /restaurants/:id(.:format)                                                               restaurants#update
#                                       PUT    /restaurants/:id(.:format)                                                               restaurants#update
#                                       DELETE /restaurants/:id(.:format)                                                               restaurants#destroy

Rails.application.routes.draw do

  resources :restaurants, defaults: { format: 'json'}
end
