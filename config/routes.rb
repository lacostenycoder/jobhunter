Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'listings#index'

  resources :listings
  resources :keywords

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase


  get '/get_new', to: 'listings#get_new'
  get '/search', to: 'listings#search'
  post '/hide_listing/:id', to: 'listings#hide'
  post '/undo', to: 'listings#undo_hide'
  get '/get_post_dates', to: 'listings#get_post_dates'
  get '/do_filters', to: 'listings#do_filters'

end
